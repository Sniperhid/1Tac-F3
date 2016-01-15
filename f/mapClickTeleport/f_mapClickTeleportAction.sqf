// F3 - Mission Maker Teleport
// Credits: Please see the F3 online manual (http://www.ferstaberinde.com/f3/en/)
// ====================================================================================

// Only run this for players
if (!hasInterface) exitWith {};

// ====================================================================================
// MAKE SURE THE PLAYER INITIALIZES PROPERLY

if (!isDedicated && (isNull player)) then {
    waitUntil {sleep 0.1; !isNull player};
};

// ====================================================================================
// SET UP VARIABLES
// Make sure all global variables are initialized

if (isNil "f_param_mapClickTeleport_Uses") then {f_param_mapClickTeleport_Uses = 0};
if (isNil "f_param_mapClickTeleport_TimeLimit") then {f_param_mapClickTeleport_TimeLimit = 0};
if (isNil "f_param_mapClickTeleport_GroupTeleport") then {f_param_mapClickTeleport_GroupTeleport = false};
if (isNil "f_param_mapClickTeleport_Units") then {f_param_mapClickTeleport_Units = []};
if (isNil "f_param_mapClickTeleport_Height") then {f_param_mapClickTeleport_Height = 0};

// Make sure that no non-existing units have been parsed
{
    f_param_mapClickTeleport_Units set [_forEachIndex,missionNamespace getVariable[_x,objNull]];
} forEach f_param_mapClickTeleport_Units;

// Reduce the array to valid units only
f_param_mapClickTeleport_Units = f_param_mapClickTeleport_Units - [objNull];

// ====================================================================================
// CHECK IF COMPONENT SHOULD BE ENABLED
// We end the script if it is not running on a server or if only group leaders can use
// the action and the player is not the leader of his/her group

if (count f_param_mapClickTeleport_Units > 0 && !(player in f_param_mapClickTeleport_Units)) exitWith {};
if (f_param_mapClickTeleport_GroupTeleport && player != leader group player)  exitWith {};

// ====================================================================================
// SET KEY VARIABLES
// Setup the localized strings for the various stages of the component
// Depending on the setting of the height variable the strings either use the teleport or the HALO option.

_string = if (f_param_mapClickTeleport_Height == 0) then {"teleport"} else {"HALO"};

f_param_mapClickTeleport_textAction = _string;
f_param_mapClickTeleport_textDone = "You have been moved to the selected location.";
f_param_mapClickTeleport_textSelect = format ["Click on the map to set %1 coordinates. ",_string];

// ====================================================================================
// ADD TELEPORT ACTION TO PLAYER ACTION MENU
// Whilst the player is alive we add the teleport action to the player's action menu.
// If the player dies we wait until he is alive again and re-add the action.

f_mapClickTeleportAction = player addaction [f_param_mapClickTeleport_textAction,{[] spawn f_fnc_mapClickTeleportUnit},"", 0, false,true,"","_this == player"];

if (f_param_mapClickTeleport_TimeLimit > 0) then {
	sleep f_param_mapClickTeleport_TimeLimit;
	player removeAction f_mapClickTeleportAction;
};