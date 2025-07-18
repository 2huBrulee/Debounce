local _, addon = ...;
addon.L = setmetatable({}, { __index = function(_, key) return key end });
local L = addon.L;

L["_HAS_TOOLTIP_SUFFIX"] = " |cffffff00(*)|r"
L["_MESSAGE_PREFIX"] = "|cff3b9de3[Debounce]|r "
L["ACTIONBARS"] = "Action Bars"
L["ADD"] = "Add..."
L["ADD_CUSTOM_TARGET_MENUS_TO_UNIT_POPUP"] = "Add custom target menus on the unit popup"
L["ADD_CUSTOM_TARGET_MENUS_TO_UNIT_POPUP_DESC"] = "Add 'Set Custom Target' menu items to the unit popup menu if possible. These menus will only work when you are out of combat."
L["ADDON_NAME"] = "Debounce"
L["ALL"] = "All"
L["BINDING_COMMAND_PAGE_FORMAT"] = "%d of %d"
L["BINDING_ERROR_BONUSBARS_NONE_SELECTED"] = "No option is selected."
L["BINDING_ERROR_CANNOT_USE_HOVER_WITH_CLIQUE"] = "Cannot be used with Clique!"
L["BINDING_ERROR_CONDITIONS_NEVER"] = "The conditions are impossible to meet."
L["BINDING_ERROR_FORMS_NONE_SELECTED"] = "No shapeshift form is selected."
L["BINDING_ERROR_GROUPS_NONE_SELECTED"] = "No option is selected."
L["BINDING_ERROR_HOVER_NONE_SELECTED"] = "No reaction or frame type is selected."
L["BINDING_ERROR_NOT_SUPPORTED_GAMEMENU_KEY"] = "The key assigned for |cFFFFFF00Toggle Game Menu|r cannot be used."
L["BINDING_ERROR_NOT_SUPPORTED_HOVER_CLICK_COMMAND"] = "Mouse buttons cannot be used for Binding Command that uses the hover condition."
L["BINDING_ERROR_NOT_SUPPORTED_MOUSE_BUTTON"] = "The left/right mouse button without modifier keys can only be used with the hover condition."
L["BINDING_ERROR_UNREACHABLE"] = "This binding is always preceded by others."
L["BINDING_TITLE"] = "%2$s (%1$s)"
L["BLIZZARD_UNIT_FRAMES_ARENA"] = "Arena Frames"
L["BLIZZARD_UNIT_FRAMES_BOSS"] = "Boss Frames"
L["BLIZZARD_UNIT_FRAMES_PARTY"] = "Party Frames"
L["BLIZZARD_UNIT_FRAMES_PET"] = "Pet Frame"
L["BLIZZARD_UNIT_FRAMES_PLAYER"] = "Player Frame"
L["BLIZZARD_UNIT_FRAMES_RAID"] = "Raid Frames"
L["BLIZZARD_UNIT_FRAMES_TARGET"] = "Target And Focus"
L["BLIZZARD_UNIT_FRAMES"] = "Blizzard unit frames"
L["CANNOT_OPEN_IN_COMBAT"] = "Cannot open in combat."
L["CHARACTER_SPECIFIC_BINDINGS"] = "%s Specific Bindings"
L["CONDITION_ACTIONBARS"] = "Action Bars"
L["CONDITION_BONUSBAR"] = "Stance-based Action Bar"
L["CONDITION_COMBAT_NO"] = "While Not in Combat"
L["CONDITION_COMBAT_YES"] = "While in Combat"
L["CONDITION_COMBAT"] = "Combat"
L["CONDITION_CUSTOM_STATES_DESC"] = "These are ON/OFF states that can be used as special conditions or macro conditional expressions in |cnLIGHTBLUE_FONT_COLOR:Macro Texts|r (Example: |cnHIGHLIGHT_FONT_COLOR:[$state1]|r). You can turn these states on or off at any time, or you can set them as macro conditionals themselves."
L["CONDITION_CUSTOM_STATES"] = "Custom States"
L["CONDITION_CUSTOM_STATE_NO"] = "When the State Is Off"
L["CONDITION_CUSTOM_STATE_YES"] = "When the State Is On"
L["CONDITION_EXTRABAR_NO"] = "When the Extra Action Button Is Not Present"
L["CONDITION_EXTRABAR_YES"] = "When the Extra Action Button Is Present"
L["CONDITION_EXTRABAR"] = "Extra Action Button"
L["CONDITION_FRAMETYPES"] = "Unit Frame Types"
L["CONDITION_GROUP"] = "Group";
L["CONDITION_HOVER_NO"] = "When Not Hovered Over"
L["CONDITION_HOVER_YES"] = "When Hovered Over"
L["CONDITION_HOVER"] = "Hovering Over Unit Frame"
L["CONDITION_IS_KNOWN"] = "Is Known"
L["CONDITION_KNOWN_YES"] = "Is Known"
L["CONDITION_KNOWN_UNKNOWN"] = "Is Unknown"
L["CONDITION_PET_NO"] = "While Without a Pet"
L["CONDITION_PET_YES"] = "While With a Pet"
L["CONDITION_PET"] = "Pet"
L["CONDITION_PETBATTLE_NO"] = "Not in a Pet Battle"
L["CONDITION_PETBATTLE_YES"] = "In a Pet Battle"
L["CONDITION_PETBATTLE"] = "Pet Battle"
L["CONDITION_REACTIONS"] = "Reactions"
L["CONDITION_SHAPESHIFT"] = "Shapeshift"
L["CONDITION_SPECIALBAR_DESC"] = "A condition caused by the replacement of the basic action bar such as vehicle, possession, etc."
L["CONDITION_SPECIALBAR_NO"] = "While a Special Bar Is Not Active"
L["CONDITION_SPECIALBAR_YES"] = "While a Special Bar Is Active"
L["CONDITION_SPECIALBAR"] = "Special Bar"
L["CONDITION_STEALTH_NO"] = "While Not Stealthed"
L["CONDITION_STEALTH_YES"] = "While Stealthed"
L["CONDITION_STEALTH"] = "Stealth"
L["CONDITION_UNIT_DOES_NOT_EXIST"] = "When the unit doesn't exist"
L["CONDITION_UNIT_EXISTS"] = "When the unit exists"
L["CONDITION_UNIT_HARM"] = "When the unit is enemy"
L["CONDITION_UNIT_HELP"] = "When the unit is friendly"
L["CONDITION_UNITS"] = "Units"
L["CONFIRM_CURRENT_CHANGE_FIRST"] = "Confirm current change first."
L["CONVERT_TO_MACRO_TEXT"] = "Convert to a |cnLIGHTBLUE_FONT_COLOR:Macro Text|r"
L["COPY_TO"] = "Copy to..."
L["CURRENT_TAB"] = "Current Tab"
L["CUSTOM_STATE_CURRENT_VALUE"] = "Current Value"
L["CUSTOM_STATE_DISPLAY_MESSAGE"] = "Show message on change."
L["CUSTOM_STATE_EDIT_VALUE_DESC"] = "Enter macro conditional expression.\n(Example: |cffffff00[@tank,exists,combat]|r)"
L["CUSTOM_STATE_EDIT_VALUE"] = "Enter macro conditional expression."
L["CUSTOM_STATE_INITIAL_VALUE"] = "Initial Value"
L["CUSTOM_STATE_LOGIN_OFF"] = "Turn off when logging in."
L["CUSTOM_STATE_LOGIN_ON"] = "Turn on when logging in."
L["CUSTOM_STATE_MODE_MACRO_CONDITIONAL_DESC"] = "This option lets the addon determine the value of the state based on macro conditional expressions (Example: |cnHIGHLIGHT_FONT_COLOR:[@healer,exists]|r)."
L["CUSTOM_STATE_MODE_MACRO_CONDITIONAL"] = "Set Automatically"
L["CUSTOM_STATE_MODE_MANUAL_DESC"] = "This option allows you to set the value of the state by yourself."
L["CUSTOM_STATE_MODE_MANUAL_INSTRUCTION"] = "You can change the value of the state here, or change it by using |cnBLUE_FONT_COLOR:Set Custom State|r action at any time (even in combat)."
L["CUSTOM_STATE_MODE_MANUAL"] = "Set Manually"
L["CUSTOM_STATE_NUM"] = "Custom State %d"
L["CUSTOM_STATE_OFF"] = "Off"
L["CUSTOM_STATE_ON"] = "On"
L["CUSTOM_STATE_REMEMBER"] = "Restore last state value when logging in."
L["CUSTOM_STATE_TOGGLE"] = "Toggle"
L["CUSTOM_STATE_TURN_OFF"] = "Turn Off"
L["CUSTOM_STATE_TURN_ON"] = "Turn On"
L["CUSTOM_STATES_DESC"] = "These are ON/OFF states that can be used as special conditions or macro conditional expressions in |cnLIGHTBLUE_FONT_COLOR:Macro Texts|r (Example: |cnHIGHLIGHT_FONT_COLOR:[$state1]|r). You can turn these states on or off at any time, or you can set them as macro conditionals themselves."
L["CUSTOM_STATES"] = "Custom States"
L["CUSTOM_TARGET_CLEAR"] = "Clear"
L["CUSTOM_TARGET_FAILED"] = "|cnHIGHLIGHT_FONT_COLOR:%s|r - |cffff0000Failed to set from '%s'|r"
L["CUSTOM_TARGET_HELP_MESSAGE_ARENA"] = "Try while hovering over arena frames."
L["CUSTOM_TARGET_HELP_MESSAGE_BOSS"] = "Try while hovering over boss frames."
L["CUSTOM_TARGET_HELP_MESSAGE_GROUP"] = "Try while hovering over party/raid frames."
L["CUSTOM_TARGET_HELP_MESSAGE_PET"] = "Try while hovering over the pet frame."
L["CUSTOM_TARGET_HELP_MESSAGE_PLAYER"] = "Try while hovering over the player frame or party/raid frames."
L["CUSTOM_TARGET_INVALIDATED"] = "|cnHIGHLIGHT_FONT_COLOR:%s|r - |cffff0000Invalided due to group roster changes|r"
L["CUSTOM_TARGET_SET_VOLATILE"] = "|cnHIGHLIGHT_FONT_COLOR:%s|r - Set to %s (This may be invalidated if group roster is changed before leaving combat.)"
L["CUSTOM_TARGET_UNSUPPORTED_UNIT_IN_COMBAT"] = "|cnHIGHLIGHT_FONT_COLOR:%s|r - |cffff0000Cannot be set from '%s' in combat|r"
L["CUSTOM_TARGET_UNSUPPORTED_UNIT"] = "|cnHIGHLIGHT_FONT_COLOR:%s|r - |cffff0000Not supported unit: %s|r"
L["DEBOUNCE_OVERVIEW_TITLE"] = "Debounce Bindings Overview"
L["DEBOUNCE_TITLE_FORMAT"] = "Debounce [%s - %s]"
L["DEFAULT"] = "Default"
L["DELETE_CONFIRM_MESSAGE"] = "Are you sure you want to delete |cffffff00%s|r?"
L["DELETE"] = "Delete"
L["DISABLE"] = "Disable"
L["DISABLE_ALL"] = "Disable All"
L["DISCARD"] = "Discard"
L["EDIT_MACRO"] = "Edit Macro"
L["ERROR_MESSAGE_CANNOT_SET_CUSTOM_TARGET_IN_COMBAT"] = "Cannot set a custom target by command while in combat."
L["EXCLUDE_PLAYER_DESC"] = "Exclude self from role-based unit detection."
L["EXCLUDE_PLAYER"] = "Exclude self"
L["FRAMETYPE_ARENA"] = "Arena Frames"
L["FRAMETYPE_BOSS"] = "Boss Frames"
L["FRAMETYPE_GROUP"] = "Party/Raid Frames"
L["FRAMETYPE_PET"] = "Pet Frame"
L["FRAMETYPE_PLAYER"] = "Player Frame"
L["FRAMETYPE_TARGET"] = "Target And Focus"
L["FRAMETYPE_UNKNOWN"] = "Others"
L["GENERAL"] = "General"
L["GROUP_NONE"] = "When Not In Group";
L["GROUP_PARTY"] = "When In Party";
L["GROUP_RAID"] = "When In Raid";
L["IGNORE_HOVER_UNIT_DESC"] = "When selected, the action ignores the unit frame's unit."
L["IGNORE_HOVER_UNIT"] = "Ignore hover unit"
L["INACTIVE_SPEC_LABEL"] = "%s (Inactive)"
L["IS_KNOWN"] = "Is Known"
L["KEY"] = "Key"
L["KEYBIND_INSTRUCTION_TEXT"] = "Mouse over |cFF00FFFFthis window|r and press the desired key to set the binding for the action."
L["LINE_TOOLTIP_CONDITION_LABEL"] = "%s:"
L["LINE_TOOLTIP_INSTRUCTION_MESSAGE1"] = "Left click to set the binding."
L["LINE_TOOLTIP_INSTRUCTION_MESSAGE2"] = "Right click for more options."
L["LINE_TOOLTIP_INSTRUCTION_MESSAGE3"] = "Drag to change the order or move it to another tab."
L["LOGIN_MESSAGE"] = "Run the /deb slash command to open the UI."
L["MACRO_POPUP_TEXT"] = "Enter Macro Name (Max 32 Characters):"
L["MACROFRAME_CHAR_LIMIT"] = "%d/1000 Characters Used"
L["MISC"] = "Misc"
L["MOVE_TO"] = "Move to..."
L["NEW_KEY_TEXT"] = "New Key: %s"
L["NO_ACTIONS_IN_THIS_TAB"] = "There are no actions in this tab. You can add a new action by dragging a spell, a macro, an item, or a mount here."
L["NO_ACTIONS_MATCHING_FILTER"] = "There are no actions that match the search terms."
L["NO_SHAPESHIFT"] = "No Shapeshift"
L["NOT_BOUND"] = "Not Bound"
L["NOT_SELECTED"] = "Not Selected"
L["ONLY_IF_UNIT_EXISTS"] = "Only if unit exists"
L["OPTIONS"] = "Options"
L["OTHER_OPTIONS"] = "Other Options"
L["OVERVIEW_LINE_TOOLTIP_INSTRUCTION_MESSAGE1"] = "Click to reveal in the main window."
L["PET"] = "Pet"
L["PREVIOUS_KEY_TEXT"] = "Previous Key: %s"
L["PRIORITY_DESC"] = "When the same key is assigned to multiple actions, the action with the highest priority among the actions that match the selected special conditions will be executed. The priority is determined by the following rules.|n|n1. Priority value that you can choose here: Very High to Very Low|n|n2. If there are special conditions set by the user|n  2.1 If the hover condition is specified, it has a higher priority than otherwise.|n  2.2 If any other special conditions are specified, they have a higher priority than those that are not.|n|n3. Priority of tabs that contain the action: Most specific to least specific|n|n4. The position of the action in the tab. The action above has a higher priority than the action below. You can change this by dragging."
L["PRIORITY"] = "Priority"
L["PRIORITY1"] = "Very High"
L["PRIORITY2"] = "High"
L["PRIORITY3"] = "Normal (Default)"
L["PRIORITY4"] = "Low"
L["PRIORITY5"] = "Very Low"
L["REACTION_ALL"] = "All"
L["REACTION_HARM"] = "Enemy"
L["REACTION_HELP"] = "Friendly"
L["REACTION_OTHER"] = "Others"
L["SAVE_OR_DISCARD_MESSAGE"] = "There are unsaved changes in this macro.\nDo you want save them or discard them?"
L["SAVE"] = "Save"
L["SELECTED_TARGET_UNIT_EMPTY"] = "Assigned Target |cnDISABLED_FONT_COLOR:(None)|r"
L["SELECTED_TARGET_UNIT"] = "Assigned Target |cnLIGHTBLUE_FONT_COLOR:(%s)|r"
L["SHARED_BINDINGS"] = "Shared Bindings"
L["SPECIAL_CONDITIONS"] = "Special Conditions"
L["SPECIAL_UNIT_SET_MESSAGE"] = "|cnHIGHLIGHT_FONT_COLOR:%s|r - Set to %s"
L["SPECIAL_UNIT_UNSET_MESSAGE_TOO_MANY"] = "|cnHIGHLIGHT_FONT_COLOR:%s|r - |cff888888Cleared (More than one unit detected)|r"
L["SPECIAL_UNIT_UNSET_MESSAGE"] = "|cnHIGHLIGHT_FONT_COLOR:%s|r - |cff888888Cleared|r"
L["SPECIAL_UNITS"] = "Special units"
L["STATE_CHANGED_MESSAGE_OFF"] = "|cnRED_FONT_COLOR:OFF|r"
L["STATE_CHANGED_MESSAGE_ON"] = "|cnGREEN_FONT_COLOR:ON|r"
L["STATE_CHANGED_MESSAGE"] = "|cff82c5ff%s|r is now %s."
L["STATE_DRIVER_UPDATE_THROTTLE"] = "State driver update throttle"
L["STATE_DRIVER_UPDATE_THROTTLE_DESC"] = "The time interval between Blizzard's state driver updates. Some states, such as those related to mouseover, may not be updated immediately. By changing this value, you can adjust the update frequency for these states. The lower the value, the more frequently the state driver updates (|cnHIGHLIGHT_FONT_COLOR:0|r means no interval at all).|n|nDon't worry. This value is not permanently saved and will reset to the default value if you disable the addon.|n|nBlizzard's default value is |cnHIGHLIGHT_FONT_COLOR:0.2|r seconds."
L["STATE_DRIVER_UPDATE_THROTTLE_WARNING"] = "Changing this value may cause performance issues."
L["TARGET_UNIT_DESC"] = "When selected, the action will be used on that unit without having it targeted(even when the hover condition is being used)."
L["TARGET_UNIT"] = "Target"
L["TYPE_COMMAND"] = "Binding Command"
L["TYPE_FOCUS"] = "Set Focus Target"
L["TYPE_ITEM"] = "Item"
L["TYPE_MACRO"] = "Macro"
L["TYPE_MACROTEXT_DESC"] = "Macros that only work within this addon. You can use special unit conditions or custom state conditions in these macros. (Example: |cnHIGHLIGHT_FONT_COLOR:/cast [@tank,exists] Rejuvenation|r)"
L["TYPE_MACROTEXT"] = "Macro Text"
L["TYPE_MOUNT"] = "Mount"
L["TYPE_SETCUSTOM_DESC"] = "Use these actions while hovering over a unit frame to assign a custom target.\n(Player, Pet, Party/Raid, Boss, Arena Unit Frames)"
L["TYPE_SETCUSTOM"] = "Set Custom Target"
L["TYPE_SETCUSTOM1"] = "Set Custom Target 1"
L["TYPE_SETCUSTOM2"] = "Set Custom Target 2"
L["TYPE_SETSTATE_DESC"] = "You can use these actions to turn on or off the custom state at any time (even in combat)."
L["TYPE_SETSTATE_OFF_NUM"] = "Turn Off Custom State %d"
L["TYPE_SETSTATE_ON_NUM"] = "Turn On Custom State %d"
L["TYPE_SETSTATE_TOGGLE_NUM"] = "Toggle Custom State %d"
L["TYPE_SETSTATE"] = "Set Custom State"
L["TYPE_SPELL"] = "Spell"
L["TYPE_TARGET"] = "Target"
L["TYPE_TOGGLEMENU"] = "Open Unit Popup Menu"
L["TYPE_UNUSED_DESC"] = "Use this action to disable the binding for a specific key in a certain situation, allowing you to use the built-in key binding settings of WoW for that key."
L["TYPE_UNUSED"] = "Disable Key"
L["TYPE_WORLDMARKER"] = "World Marker"
L["UNABLE_TO_REGISTER_UNIT_FRAME_IN_COMBAT"] = "Unable to register some unit frames due to being in combat. They will be registered when combat is over."
L["UNBIND"] = "Unbind Key"
L["UNIT_CUSTOM1"] = "Custom Target 1"
L["UNIT_CUSTOM2"] = "Custom Target 2"
L["UNIT_DISABLE"] = "Disable"
L["UNIT_FOCUS"] = "Focus"
L["UNIT_HEALER"] = "Healer"
L["UNIT_HOVER_DESC"] = "The hovered unit frame's unit"
L["UNIT_HOVER"] = "Unit Frame"
L["UNIT_MAINASSIST"] = "Main Assist"
L["UNIT_MAINTANK"] = "Main Tank"
L["UNIT_MOUSEOVER"] = "Mouseover"
L["UNIT_NONE_DESC"] = "When selected, you can select a new target, even if a currently selected target exists. It also ignores auto self cast."
L["UNIT_NONE"] = "No Target"
L["UNIT_PET"] = "Pet"
L["UNIT_PLAYER"] = "Player"
L["UNIT_ROLE_DESC"] = "If Tank, Healer, Main Tank or Main Assist is selected, only one that role must exist within the party/raid for it to work."
L["UNIT_TANK"] = "Tank"
L["UNIT_TARGET"] = "Target"
L["UNITFRAME_OPTIONS"] = "Unit frame options"
L["UNITFRAME_TRIGGER_ON_MOUSE_DOWN_DESC"] = "Trigger the action on mouse down instead of on mouse up for unit frames. Blizzard’s default value is mouse up."
L["UNITFRAME_TRIGGER_ON_MOUSE_DOWN"] = "Use mouse down for click casting"
L["UNNAMED_ACTION"] = "(Unnamed)"
L["WARNING_MESSAGE_CLIQUE_DETECTED"] = "Because you are using Clique, some features of this addon will not work."
