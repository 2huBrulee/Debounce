local _, DebouncePrivate              = ...;
local Constants                       = DebouncePrivate.Constants;
local CUSTOM_TARGET_VALID_UNIT_TOKENS = Constants.CUSTOM_TARGET_VALID_UNIT_TOKENS;
local LLL                             = DebouncePrivate.L;
local BindingDriver                   = DebouncePrivate.BindingDriver;
local UnitWatch                       = CreateFrame("Frame", nil, nil, "SecureFrameTemplate,SecureHandlerAttributeTemplate");
local dump                            = DebouncePrivate.dump;

DebouncePrivate.UnitWatch             = UnitWatch;
DebouncePrivate.UnitWatchHeaders      = {};


SecureHandlerSetFrameRef(UnitWatch, "debounce_driver", BindingDriver);
SecureHandlerExecute(UnitWatch, [=[
    unitwatch = self
    debounce_driver = self:GetFrameRef("debounce_driver")
    UnitwatchHeaders = newtable()
    ChildFrames = newtable()
    unitNames = newtable()
    unitMap = newtable()
    CUSTOM_TARGET_VALID_UNIT_TOKENS = newtable()
]=]);
do
    local tmp = {};
    for k, v in pairs(CUSTOM_TARGET_VALID_UNIT_TOKENS) do
        tmp[#tmp + 1] = format("CUSTOM_TARGET_VALID_UNIT_TOKENS[%q]=%q", k, v);
    end
    SecureHandlerExecute(UnitWatch, table.concat(tmp, "\n"));
    tmp = nil;
end

---------------------------------------
-- UpdateGroupRoster
do
    local _prevUnitNameMap = {};
    function UnitWatch:UpdateGroupRoster()
        if (InCombatLockdown()) then
            return;
        end

        local unitNameMap = {};
        if (IsInRaid()) then
            for i = 1, MAX_RAID_MEMBERS do
                local unitToken = "raid" .. i;
                unitNameMap[unitToken] = DebouncePrivate.GetUnitFullName(unitToken);
            end
        end
        if (IsInRaid() or IsInGroup()) then
            for i = 1, MAX_PARTY_MEMBERS do
                local unitToken = "party" .. i;
                unitNameMap[unitToken] = DebouncePrivate.GetUnitFullName(unitToken);
            end
        end

        if (next(unitNameMap) == nil) then
            if (next(_prevUnitNameMap) ~= nil) then
                SecureHandlerExecute(UnitWatch, "wipe(unitNames)");
            end
        else
            local strArr = {};
            for k, v in pairs(unitNameMap) do
                if (_prevUnitNameMap[k] ~= v) then
                    strArr[#strArr + 1] = format("unitNames[%q]=%q", k, v);
                end
            end
            for k in pairs(_prevUnitNameMap) do
                if (unitNameMap[k] == nil) then
                    strArr[#strArr + 1] = format("unitNames[%q]=nil", k);
                end
            end
            if (#strArr > 0) then
                SecureHandlerExecute(UnitWatch, table.concat(strArr, "\n"));
            end
        end

        _prevUnitNameMap = unitNameMap;
        UnitWatch:SetAttribute("grouproster_uptodate", true);
    end
end

local CreateUnitWatchHeader;
do
    local CheckUnits = [=[
local alias, matchedUnit, tooMany = %q
local header = UnitwatchHeaders[alias]
if (not header:IsShown()) then
    return
end

for i = 1, %d do
    local child = ChildFrames[alias][i]
    local unit = child:GetAttribute("unit")
    if (unit) then
        if (matchedUnit) then
            matchedUnit = nil
            tooMany = true
            break
        else
            matchedUnit = unit
        end
    else
        break
    end
end

if (unitMap[alias] ~= matchedUnit) then
    unitMap[alias] = matchedUnit
    if (debounce_driver:RunAttribute("SetUnit", alias, matchedUnit)) then
        debounce_driver:RunAttribute("UpdateBindings")
    end
    if (tooMany) then
        unitwatch:CallMethod("OnSpecialUnitChanging", alias, false)
    else
        unitwatch:CallMethod("OnSpecialUnitChanging", alias, matchedUnit)
    end
end
self:Show()
]=];

    function CreateUnitWatchHeader(alias, numFrames, ...)
        local header = CreateFrame("Button", nil, nil, "SecureGroupHeaderTemplate");
        DebouncePrivate.UnitWatchHeaders[alias] = header;
        header:Hide();

        header:SetAttribute("alias", alias);
        header:SetAttribute("showParty", true);
        header:SetAttribute("showRaid", true);
        if (strsub(alias, 1, 6) ~= "custom"
                and DebouncePrivate.Options.excludePlayer
                and DebouncePrivate.Options.excludePlayer[alias]) then
            header:SetAttribute("showPlayer", false);
        else
            header:SetAttribute("showPlayer", true);
        end
        header:SetAttribute("showSolo", true);
        header:SetAttribute("groupingOrder", "1,2,3,4,5,6,7,8");
        header:SetAttribute("sortMethod", "NAME");
        header:SetAttribute("maxColumns", 1);
        header:SetAttribute("unitsPerColumn", numFrames);
        header:SetAttribute("template", "");
        header:SetAttribute("templateType", "Frame");

        for i = 1, select("#", ...), 2 do
            header:SetAttribute(select(i, ...), select(i + 1, ...));
        end

        for i = 1, numFrames do
            local childFrame = CreateFrame("Button", nil, header, "SecureFrameTemplate");
            header:SetAttribute("child" .. i, childFrame);
            SecureHandlerSetFrameRef(header, "child" .. i, childFrame);
        end

        SecureHandlerSetFrameRef(UnitWatch, "unitwatch_header", header);
        SecureHandlerExecute(UnitWatch, ([=[
            local alias, numFrames = %q, %d
            local header = self:GetFrameRef("unitwatch_header")
            UnitwatchHeaders[alias] = header
            ChildFrames[alias] = newtable()
            for i = 1, numFrames do
                ChildFrames[alias][i] = header:GetFrameRef("child"..i)
            end
        ]=]):format(alias, numFrames));

        local lastChildFrame = CreateFrame("Frame", nil, header, "SecureFrameTemplate");
        header:SetAttribute("child" .. (numFrames + 1), lastChildFrame);
        SecureHandlerWrapScript(lastChildFrame, "OnHide", UnitWatch, CheckUnits:format(alias, numFrames));

        return header;
    end
end

do
    local header = CreateFrame("Frame", nil, nil, "SecureGroupHeaderTemplate");
    header:SetAttribute("showParty", true);
    header:SetAttribute("showRaid", true);
    header:SetAttribute("showSolo", true);
    header:SetAttribute("groupFilter", "1,2,3,4,5,6,7,8");
    header:SetAttribute("maxColumns", 1);
    header:SetAttribute("unitsPerColumn", 1);
    header:SetAttribute("template", "");
    header:SetAttribute("templateType", "Frame");

    local childFrame = CreateFrame("Button", nil, header, "SecureFrameTemplate");
    header:SetAttribute("child1", childFrame);
    SecureHandlerSetFrameRef(header, "child1", childFrame);

    local lastChildFrame = CreateFrame("Frame", nil, header, "SecureFrameTemplate");
    header:SetAttribute("child2", lastChildFrame);

    SecureHandlerWrapScript(lastChildFrame, "OnHide", UnitWatch, [==[
        unitwatch:SetAttribute("grouproster_uptodate", false)
        unitwatch:CallMethod("UpdateGroupRoster")
		self:Show()
    ]==]);

    header:Show()
end

do
    local UNITWATCH_HEADER_PROPS = {
        tank = { 2, "roleFilter", "TANK", "showSolo", false },
        healer = { 2, "roleFilter", "HEALER", "showSolo", false },
        maintank = { 2, "roleFilter", "MAINTANK", "showSolo", false },
        mainassist = { 2, "roleFilter", "MAINASSIST", "showSolo", false },
        custom1 = { 1, "nameList", "" },
        custom2 = { 1, "nameList", "" },
    };

    function DebouncePrivate.GetUnitWatchHeader(alias, allowCreate)
        local header = DebouncePrivate.UnitWatchHeaders[alias];
        if (not header and allowCreate) then
            if (not UNITWATCH_HEADER_PROPS[alias]) then
                return;
            end
            header = CreateUnitWatchHeader(alias, unpack(UNITWATCH_HEADER_PROPS[alias]));
        end
        return header;
    end

    function DebouncePrivate.EnableUnitWatch(unit, ...)
        local header = DebouncePrivate.UnitWatchHeaders[unit];
        if (not header) then
            if (not UNITWATCH_HEADER_PROPS[unit]) then
                return;
            end
            header = CreateUnitWatchHeader(unit, unpack(UNITWATCH_HEADER_PROPS[unit]));
        end

        local n = select("#", ...);
        if (n > 0) then
            for i = 1, 2, 2 do
                header:SetAttribute(select(i, ...), select(i + 1, ...));
            end
        end

        header:Show();
        return header;
    end

    function DebouncePrivate.DisableUnitWatch(unit, ...)
        local header = DebouncePrivate.UnitWatchHeaders[unit];
        if (header and header:IsShown()) then
            header:Hide();
            SecureHandlerExecute(UnitWatch, format("unitMap[%q] = nil", unit));
            UnitWatch:OnSpecialUnitChanging(unit, nil);
        end
    end
end

CreateUnitWatchHeader("custom1", 1, "nameList", "");
CreateUnitWatchHeader("custom2", 1, "nameList", "");

-- false 실패
-- nil unset
-- value
local function DoResolveUnitToken(value)
    if (strsub(value, 1, 1) == ":") then
        return value;
    end

    local unitType = CUSTOM_TARGET_VALID_UNIT_TOKENS[value];
    if (unitType) then
        return value, unitType;
    end

    if (UnitExists(value)) then
        if (UnitIsUnit(value, "player")) then
            return "player", "player";
        elseif (UnitIsUnit(value, "pet")) then
            return "pet", "pet";
        end

        -- target focus targettarget focustarget mouseover etc etc
        local raidID = UnitInRaid(value);
        if (raidID) then
            return "raid" .. raidID, "group";
        elseif (UnitInParty(value)) then
            for i = 1, MAX_PARTY_MEMBERS do
                if (UnitIsUnit("party" .. i, value)) then
                    return "party" .. i, "group";
                end
            end
        end

        for i = 1, Constants.MAX_BOSSES do
            if (UnitIsUnit("boss" .. i, value)) then
                return "boss" .. i, "boss";
            end
        end

        for i = 1, MAX_ARENA_ENEMIES do
            if (UnitIsUnit("arena" .. i, value)) then
                return "arena" .. i, "arena";
            end
        end

        return false;
    end

    return nil;
end

function UnitWatch:ResolveUnitToken(unitToken)
    if (InCombatLockdown()) then
        return;
    end
    local resolvedUnit = DoResolveUnitToken(unitToken);
    self:SetAttribute("resolvedUnit", resolvedUnit);
end

function UnitWatch:LoadCustomTargets()
    if (DebouncePrivate.db.char.CustomTargets) then
        for i = 1, 2 do
            local alias = "custom" .. i;
            local savedValue = DebouncePrivate.db.char.CustomTargets[alias];
            if (savedValue) then
                UnitWatch:SetAttribute(alias, savedValue);
            end
        end
    end
end

do
    local _lastSeen = {};
    local _changedAliases = {};
    local _sortedUnits = { "custom1", "custom2", "tank", "healer" };

    local function CustomTargetsChangedCallback()
        for _, alias in ipairs(_sortedUnits) do
            local info = _changedAliases[alias];
            if (info) then
                if (alias == "custom1" or alias == "custom2") then
                    local value = DebouncePrivate.Units[alias];
                    local set = info.set;
                    local invalidating = info.invalidating;
                    local unitName, isVolatile, saveValue, guid;

                    if (value) then
                        local unitType = CUSTOM_TARGET_VALID_UNIT_TOKENS[value];
                        unitName = DebouncePrivate.GetUnitFullName(value);
                        guid = UnitGUID(value);
                        if (unitType == "group") then
                            isVolatile = not DebouncePrivate.UnitWatchHeaders[alias]:IsShown();
                            if (unitName) then
                                saveValue = ":" .. unitName;
                            end
                        else
                            saveValue = value;
                        end
                    elseif (DebouncePrivate.UnitWatchHeaders[alias]:IsShown()) then
                        unitName = DebouncePrivate.UnitWatchHeaders[alias]:GetAttribute("nameList");
                        if (unitName) then
                            saveValue = ":" .. unitName;
                        end
                    end

                    DebouncePrivate.db.char.CustomTargets = DebouncePrivate.db.char.CustomTargets or {};
                    DebouncePrivate.db.char.CustomTargets[alias] = saveValue;

                    if (set or _lastSeen[alias] ~= guid) then
                        _lastSeen[alias] = guid;
                        if (value or unitName) then
                            local color;
                            if (value and UnitExists(value)) then
                                if (UnitIsPlayer(value)) then
                                    local _, classFilename = UnitClass(value);
                                    color = GetClassColorObj(classFilename);
                                else
                                    color = CreateColor(UnitSelectionColor(value));
                                end
                            else
                                color = GRAY_FONT_COLOR;
                            end
                            local colorCodedName = color:WrapTextInColorCode(unitName or value);
                            if (isVolatile) then
                                DebouncePrivate.DisplayMessage(format(LLL["CUSTOM_TARGET_SET_VOLATILE"], LLL["UNIT_" .. strupper(alias)], colorCodedName));
                            else
                                DebouncePrivate.DisplayMessage(format(LLL["SPECIAL_UNIT_SET_MESSAGE"], LLL["UNIT_" .. strupper(alias)], colorCodedName));
                            end
                        elseif (invalidating) then
                            DebouncePrivate.DisplayMessage(format(LLL["CUSTOM_TARGET_INVALIDATED"], LLL["UNIT_" .. strupper(alias)]));
                        else
                            DebouncePrivate.DisplayMessage(format(LLL["SPECIAL_UNIT_UNSET_MESSAGE"], LLL["UNIT_" .. strupper(alias)]));
                        end
                    end
                else
                    local value = DebouncePrivate.Units[alias] or nil;
                    local invalidating = info.invalidating;
                    local unitName, guid;

                    if (value) then
                        unitName = DebouncePrivate.GetUnitFullName(value);
                        guid = UnitGUID(value);
                    end

                    if (_lastSeen[alias] ~= guid) then
                        _lastSeen[alias] = guid;
                        if (value or unitName) then
                            local color;
                            if (value and UnitExists(value)) then
                                if (UnitIsPlayer(value)) then
                                    local _, classFilename = UnitClass(value);
                                    color = GetClassColorObj(classFilename);
                                else
                                    color = CreateColor(UnitSelectionColor(value));
                                end
                            else
                                color = GRAY_FONT_COLOR;
                            end
                            local colorCodedName = color:WrapTextInColorCode(unitName or value);
                            DebouncePrivate.DisplayMessage(format(LLL["SPECIAL_UNIT_SET_MESSAGE"], LLL["UNIT_" .. strupper(alias)], colorCodedName));
                        elseif (invalidating) then
                            DebouncePrivate.DisplayMessage(format(LLL["SPECIAL_UNIT_UNSET_MESSAGE_TOO_MANY"], LLL["UNIT_" .. strupper(alias)]));
                        else
                            DebouncePrivate.DisplayMessage(format(LLL["SPECIAL_UNIT_UNSET_MESSAGE"], LLL["UNIT_" .. strupper(alias)]));
                        end
                    end
                end
            end
        end

        wipe(_changedAliases);
    end

    function UnitWatch:OnSpecialUnitChanging(alias, value, set)
        if (not next(_changedAliases)) then
            C_Timer.After(0, CustomTargetsChangedCallback);
        end
        _changedAliases[alias] = _changedAliases[alias] or {};
        _changedAliases[alias].value = value or nil;
        _changedAliases[alias].set = _changedAliases[alias].set or set;
        _changedAliases[alias].invalidating = value == false;
    end

    function UnitWatch:OnSetCustomTargetFailed(alias, value, originalValue)
        local resolvedUnit, unitType = DoResolveUnitToken(value);
        if (resolvedUnit == false) then
            DebouncePrivate.DisplayMessage(format(LLL["CUSTOM_TARGET_UNSUPPORTED_UNIT"], LLL["UNIT_" .. strupper(alias)], DebouncePrivate.GetUnitFullName(value)));
        else
            if (InCombatLockdown()) then
                local helpMessage;
                if ((originalValue == "hover" or originalValue == "mouseover") and unitType) then
                    helpMessage = rawget(LLL, "CUSTOM_TARGET_HELP_MESSAGE_" .. unitType:upper());
                end
                helpMessage = helpMessage or "";
                DebouncePrivate.DisplayMessage(format(LLL["CUSTOM_TARGET_UNSUPPORTED_UNIT_IN_COMBAT"], LLL["UNIT_" .. strupper(alias)], value, helpMessage));
            else
                DebouncePrivate.DisplayMessage(format(LLL["CUSTOM_TARGET_FAILED"], LLL["UNIT_" .. strupper(alias)], value));
            end
        end
    end
end

UnitWatch:SetAttribute("_onattributechanged", [==[
    if (name == "grouproster_uptodate") then
        for i = 1, 2 do
            local alias = "custom"..i
            local unit = unitMap[alias]
            if (CUSTOM_TARGET_VALID_UNIT_TOKENS[unit] == "group") then
                if (not UnitwatchHeaders[alias]:IsShown()) then
                    if (value) then
                        local unitName = unitNames[unit]
                        if (unitName) then
                            self:SetAttribute(alias, ":"..unitName)
                        end
                    else
                        self:SetAttribute(alias, false)
                    end
                end
            end
        end
    elseif (name == "custom1" or name == "custom2") then
        local alias, unit, nameList, failed = name, value or nil
		if (unit) then
			unit = strtrim(unit)
            if (unit == "" or unit == "none" or unit == ":") then
                unit = nil
			elseif (unit == "hover") then
                unit = debounce_driver:RunAttribute("GetHoveredUnit")
            end
		end

		if (unit) then
			self:SetAttribute("resolvedUnit", unit)
			self:CallMethod("ResolveUnitToken", unit)
            unit = self:GetAttribute("resolvedUnit") or unit
		end

        if (unit ~= unitMap[alias]) then
            if (unit) then
                if (CUSTOM_TARGET_VALID_UNIT_TOKENS[unit]) then
                    if (CUSTOM_TARGET_VALID_UNIT_TOKENS[unit] == "group") then
                        if (UnitExists(unit)) then
                            if (self:GetAttribute("grouproster_uptodate")) then
                                nameList = unitNames[unit]
                            end
                        else
                            unit = nil
                        end
                    end
                elseif (strsub(unit, 1, 1) == ":") then
                    nameList = strsub(value, 2)
                elseif (UnitExists(unit)) then
                    self:CallMethod("OnSetCustomTargetFailed", alias, unit, value)
                    return
                else
                    unit = nil
                end
            end

            local header = UnitwatchHeaders[alias]
            if (nameList) then
                header:SetAttribute("nameList", nameList)
                header:Show()
            else
                header:Hide()
                if (unitMap[alias] ~= unit) then
                    unitMap[alias] = unit
                    if (debounce_driver:RunAttribute("SetUnit", alias, unit or nil)) then
                        debounce_driver:RunAttribute("UpdateBindings")
                    end
                end
            end
        end

        if (value == false) then
            self:CallMethod("OnSpecialUnitChanging", alias, false)
        else
            self:CallMethod("OnSpecialUnitChanging", alias, unit, true)
        end
	end
]==]);

UnitWatch:SetScript("OnEvent", function(_, event, arg1)
    if (event == "PLAYER_LOGIN") then
        UnitWatch:UpdateGroupRoster();
        UnitWatch:LoadCustomTargets();
        UnitWatch:RegisterEvent("PLAYER_REGEN_ENABLED");
        UnitWatch:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT");
        UnitWatch:RegisterEvent("ARENA_OPPONENT_UPDATE");
        UnitWatch:RegisterUnitEvent("UNIT_PET", "player");
    elseif (event == "PLAYER_REGEN_ENABLED") then
        if (not UnitWatch:GetAttribute("grouproster_uptodate")) then
            UnitWatch:UpdateGroupRoster();
        end
    elseif (event == "UNIT_PET") then
        if (arg1 == "player") then
            for i = 1, 2 do
                local alias = "custom" .. i;
                if (DebouncePrivate.Units[alias] == "pet") then
                    UnitWatch:OnSpecialUnitChanging(alias, "pet");
                end
            end
        end
    elseif (event == "INSTANCE_ENCOUNTER_ENGAGE_UNIT") then
        for i = 1, 2 do
            local alias = "custom" .. i;
            local value = DebouncePrivate.Units[alias];
            if (value and CUSTOM_TARGET_VALID_UNIT_TOKENS[value] == "boss") then
                UnitWatch:OnSpecialUnitChanging(alias, value);
            end
        end
    elseif (event == "ARENA_OPPONENT_UPDATE") then
        local value = arg1;
        for i = 1, 2 do
            local alias = "custom" .. i;
            if (DebouncePrivate.Units[alias] == value) then
                UnitWatch:OnSpecialUnitChanging(alias, value);
            end
        end
    end
end);
UnitWatch:RegisterEvent("PLAYER_LOGIN");

for i = 1, 2 do
    local button = CreateFrame("Button", "DebounceCustom" .. i, nil, "SecureActionButtonTemplate");
    button:SetAttribute("alias", "custom" .. i);
    SecureHandlerWrapScript(button, "OnClick", UnitWatch, [==[
        local alias = self:GetAttribute("alias")
        local value = button
        if (not value or value == "LeftButton") then
            value = nil
        end
        unitwatch:SetAttribute(alias, value)
    ]==]);
end

local function AddCustomTargetMenus(owner, rootDescription, contextData)
    if (not DebouncePrivate.Options.addCustomTargetMenusToUnitPopup) then
        return;
    end
    if (InCombatLockdown()) then
        return;
    end
    if (not contextData.unit) then
        return;
    end

    local unit = DoResolveUnitToken(contextData.unit);
    if (unit) then
        rootDescription:CreateDivider();
        rootDescription:CreateTitle(LLL["ADDON_NAME"]);
        for i = 1, 2 do
            local desc = rootDescription:CreateButton(LLL["TYPE_SETCUSTOM" .. i], function()
                if (not InCombatLockdown()) then
                    DebouncePrivate.UnitWatch:SetAttribute("custom" .. i, unit);
                end
            end);
            desc:SetEnabled(function()
                return not InCombatLockdown();
            end);
            -- desc:AddInitializer(function(button, elementDescription, menu)
            --     local current = DebouncePrivate.Units["custom" .. i];
            --     if (current and UnitIsUnit(unit, current)) then
            --         button.fontString:SetTextColor(BLUE_FONT_COLOR:GetRGB());
            --     else
            --         button.fontString:SetTextColor(HIGHLIGHT_FONT_COLOR:GetRGB());
            --     end
            -- end);
        end
    end
end

Menu.ModifyMenu("MENU_UNIT_SELF", AddCustomTargetMenus);
Menu.ModifyMenu("MENU_UNIT_TARGET", AddCustomTargetMenus);
Menu.ModifyMenu("MENU_UNIT_FOCUS", AddCustomTargetMenus);
Menu.ModifyMenu("MENU_UNIT_PARTY", AddCustomTargetMenus);
Menu.ModifyMenu("MENU_UNIT_RAID", AddCustomTargetMenus);
Menu.ModifyMenu("MENU_UNIT_BOSS", AddCustomTargetMenus); -- not tested
Menu.ModifyMenu("MENU_UNIT_ARENA", AddCustomTargetMenus); -- not tested