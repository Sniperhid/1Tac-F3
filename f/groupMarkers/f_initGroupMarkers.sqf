private ["_unitfaction"];

if (!hasInterface) exitWith {}; // Only needed on clients

// ====================================================================================
// MAKE SURE THE PLAYER INITIALIZES PROPERLY
if (!isDedicated && (isNull player)) then {
    waitUntil {sleep 0.1; !isNull player};
};

// ====================================================================================

// DETECT PLAYER FACTION
// The following code detects what faction the player's slot belongs to, and stores
// it in the private variable _unitfaction
_unitfaction = toLower (faction (leader group player));

//Update delay in seconds between updates.
f_grpMkr_delay = 3; 

// setup the displays
[] call f_addon_fnc_setupDisplays;

// setup the markers.
[_unitfaction,true] call f_fnc_setupGroupMarkers;
