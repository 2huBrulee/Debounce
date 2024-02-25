local _, DebouncePrivate                  = ...;
DebouncePrivate.Constants                 = {};
local Constants                           = DebouncePrivate.Constants;

Constants.DEBUG                           = true;
Constants.NIL                             = "\0";
Constants.DB_VERSION                      = 2;
Constants.MAX_NUM_ACTIONS_PER_LAYER       = 1000;
Constants.CLICKBINDING_NON_MOD_PREFIX     = ""; -- "" or "*"
Constants.STATE_DRIVER_UPDATETIME_DEFAULT = 0.2;
Constants.PLAYER_CLASS                    = select(2, UnitClass("player"));
        
-- 같은 키로 지정된 여러개의 action들을 하나의 매크로로 조합. 이 경우 상태 변경을 감지하지 않아도 된다.
-- 일부 조건(mouseover 등)은 상태 변경을 즉각적으로 감지할 수 없기 때문에 상태 변경 감지에 의존하는 건 딜레이가 생길 수 있다.(기본 wow 코드 상으로는 최대 0.2초)
-- 하나의 매크로로 조합하게 되면 조건 체크가 단축키를 누르는 순간 이루어지기때문에 위의 문제가 사라진다.
-- 애드온이 하는 일이 줄어들기 때문에 성능 상의 이점도 있을 것?
-- 매크로로 조합할 수 없는 경우
--      UNUSED, COMMAND 등 SetOverrideBindingClick으로 바인딩할 수 없는 경우: 매크로로 이 행동을 실행할 수 있는 방법이 없다.
-- 		하나 이상의 유닛을 체크하는 경우: 두 개 이상의 유닛을 동시에 체크할 수 없다. (예외: pet은 항상 체크 가능)
--      frameTypes 조건을 사용하는 경우. 억지로 가능하게 만들 수는 있지만 조합하는 이점이 사라진다.
--      모든 바인딩이 conditional인 경우. 조건이 맞지 않을 경우 단축키를 해제해야하므로 매크로만으로는 불가능.
Constants.ALLOW_COMBINE_CLICK             = false;
Constants.ALLOW_COMBINE_NON_CLICK         = false;

-- Action Types
Constants.SPELL                           = "spell";
Constants.ITEM                            = "item";
Constants.MACRO                           = "macro";
Constants.MACROTEXT                       = "macrotext";
Constants.MOUNT                           = "mount";
Constants.TARGET                          = "target";
Constants.FOCUS                           = "focus";
Constants.TOGGLEMENU                      = "togglemenu";
Constants.COMMAND                         = "command";
Constants.WORLDMARKER                     = "worldmarker";
Constants.SETCUSTOM                       = "setcustom";
Constants.SETSTATE                        = "setstate";
Constants.UNUSED                          = "unused";
Constants.COMBINED                        = "_combined";


Constants.MAX_NUM_CUSTOM_STATES = 5;

Constants.CUSTOM_STATE_INDICES  = {};
for i = 1, Constants.MAX_NUM_CUSTOM_STATES do
    Constants.CUSTOM_STATE_INDICES["$state" .. i] = i;
end

Constants.CUSTOM_STATE_MODES    = {
    MANUAL            = 0,
    ALWAYS_ON         = 1,
    ALWAYS_OFF        = 2,
    MACRO_CONDITIONAL = 3,
};

Constants.SETCUSTOM_MODE_ON     = 0x100;
Constants.SETCUSTOM_MODE_OFF    = 0x200;
Constants.SETCUSTOM_MODE_TOGGLE = 0x400;
Constants.SETCUSTOM_MODE_MASK   = 0x100 + 0x200 + 0x400;


Constants.MACROTEXT_ARG_UNIT         = 1;
Constants.MACROTEXT_ARG_CUSTOM_STATE = 2;


-- Priority Values
Constants.DEFAULT_PRIORITY    = 3;

Constants.GROUP_NONE          = 2 ^ 0;
Constants.GROUP_PARTY         = 2 ^ 1;
Constants.GROUP_RAID          = 2 ^ 2;
Constants.GROUP_ALL           = 2 ^ 3 - 1;

Constants.FORM_ALL            = 2 ^ 11 - 1;

Constants.MAX_BONUSBAR_OFFSET = 5;
Constants.BONUSBAR_ALL        = 2 ^ (Constants.MAX_BONUSBAR_OFFSET + 1) - 1;


-- Unit Frame Reactions
Constants.REACTION_HELP  = 2 ^ 0;
Constants.REACTION_HARM  = 2 ^ 1;
Constants.REACTION_OTHER = 2 ^ 2;
Constants.REACTION_ALL   = 2 ^ 3 - 1;
Constants.REACTION_NONE  = 2 ^ 4;


-- Unit Frame Types
Constants.FRAMETYPE_UNKNOWN = 2 ^ 0;
Constants.FRAMETYPE_PLAYER  = 2 ^ 1;
Constants.FRAMETYPE_PET     = 2 ^ 2;
Constants.FRAMETYPE_GROUP   = 2 ^ 3;
Constants.FRAMETYPE_TARGET  = 2 ^ 4;
Constants.FRAMETYPE_BOSS    = 2 ^ 5;
Constants.FRAMETYPE_ARENA   = 2 ^ 6;
Constants.FRAMETYPE_ALL     = 2 ^ 7 - 1;


-- Binding Issues
Constants.BINDING_ISSUE_NOT_SUPPORTED_GAMEMENU_KEY        = "NOT_SUPPORTED_GAMEMENU_KEY";
Constants.BINDING_ISSUE_NOT_SUPPORTED_MOUSE_BUTTON        = "NOT_SUPPORTED_MOUSE_BUTTON";
Constants.BINDING_ISSUE_NOT_SUPPORTED_HOVER_CLICK_COMMAND = "NOT_SUPPORTED_HOVER_CLICK_COMMAND";
Constants.BINDING_ISSUE_CONDITIONS_NEVER                  = "CONDITIONS_NEVER";
Constants.BINDING_ISSUE_UNREACHABLE                       = "UNREACHABLE";
Constants.BINDING_ISSUE_CLIQUE_DETECTED                   = "CLIQUE_DETECTED";
Constants.BINDING_ISSUE_CANNOT_USE_HOVER_WITH_CLIQUE      = "CANNOT_USE_HOVER_WITH_CLIQUE";
Constants.BINDING_ISSUE_FORMS_NONE_SELECTED               = "FORMS_NONE_SELECTED";
Constants.BINDING_ISSUE_BONUSBARS_NONE_SELECTED           = "BONUSBARS_NONE_SELECTED";
Constants.BINDING_ISSUE_GROUPS_NONE_SELECTED              = "GROUPS_NONE_SELECTED";
Constants.BINDING_ISSUE_HOVER_NONE_SELECTED               = "HOVER_NONE_SELECTED";


local SPECIAL_UNITS     = {
    tank = 1,
    healer = 2,
    maintank = 3,
    mainassist = 4,
    custom1 = 5,
    custom2 = 6,
    hover = 7,
};

Constants.SPECIAL_UNITS = SPECIAL_UNITS;

local BASIC_UNITS       = {
    mouseover = 11,
    player = 12,
    pet = 13,
    target = 14,
    focus = 15,
    none = 16,
    [""] = 17,
};

Constants.BASIC_UNITS   = BASIC_UNITS;


Constants.MAX_BOSSES                                = 8;

Constants.CUSTOM_TARGET_VALID_UNIT_TOKENS           = {};
Constants.CUSTOM_TARGET_VALID_UNIT_TOKENS["player"] = "player";
Constants.CUSTOM_TARGET_VALID_UNIT_TOKENS["pet"]    = "pet";
for i = 1, MAX_PARTY_MEMBERS do
    Constants.CUSTOM_TARGET_VALID_UNIT_TOKENS["party" .. i] = "group"
end
for i = 1, MAX_RAID_MEMBERS do
    Constants.CUSTOM_TARGET_VALID_UNIT_TOKENS["raid" .. i] = "group"
end
for i = 1, Constants.MAX_BOSSES do
    Constants.CUSTOM_TARGET_VALID_UNIT_TOKENS["boss" .. i] = "boss"
end
for i = 1, MAX_ARENA_ENEMIES do
    Constants.CUSTOM_TARGET_VALID_UNIT_TOKENS["arena" .. i] = "arena"
end



if (Constants.DEBUG) then
    if (_G.DevTool and _G.DevTool.AddData) then
        local DevTool = _G.DevTool;
        function DebouncePrivate.dump(strName, tData)
            DevTool:AddData(tData, "[" .. GetTime() .. "] " .. (strName or ""));
        end
    elseif (_G.ViragDevTool_AddData) then
        local ViragDevTool_AddData = _G.ViragDevTool_AddData;
        function DebouncePrivate.dump(strName, tData)
            ViragDevTool_AddData(tData, "[" .. GetTime() .. "] " .. (strName or ""));
        end
    end
end
DebouncePrivate.dump = DebouncePrivate.dump or function() end
DebouncePrivate.dump("DebouncePrivate", DebouncePrivate);
