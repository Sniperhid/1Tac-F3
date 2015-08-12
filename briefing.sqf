// F3 - Briefing
// Credits: Please see the F3 online manual (http://www.ferstaberinde.com/f3/en/)
// ====================================================================================
if (!hasInterface) exitWith {};

// MAKE SURE THE PLAYER INITIALIZES PROPERLY

if (isNull player) then {
    waitUntil {uiSleep 1; !isNull player};
};

// ====================================================================================
// DETECT PLAYER FACTION
// The following code detects what faction the player's slot belongs to, and stores it in the private variable _unitfaction

private ["_unitfaction"];
_unitfaction = toLower (faction (leader group player));

// ====================================================================================
// BRIEFING: ADMIN
// The following block of code executes only if the player is the current host  it automatically includes a file which contains the appropriate briefing data.

if (serverCommandAvailable "#kick") then {
    #include "f\briefing\f_briefing_admin.sqf"
};

// ====================================================================================
// BRIEFING: BLUFOR > NATO
// The following block of code executes only if the player is in a NATO slot; it automatically includes a file which contains the appropriate briefing data.

if (_unitfaction isEqualTo "blu_f") exitWith {
    #include "f\briefing\f_briefing_nato.sqf"
};

// ====================================================================================
// BRIEFING: FIA
// The following block of code executes only if the player is in a FIA slot; it automatically includes a file which contains the appropriate briefing data.

if (_unitfaction in ["blu_g_f","ind_g_f","opf_g_f"]) exitWith {
    #include "f\briefing\f_briefing_fia.sqf"
};

// ====================================================================================
// BRIEFING: OPFOR > CSAT
// The following block of code executes only if the player is in a CSAT slot; it automatically includes a file which contains the appropriate briefing data.

if (_unitfaction isEqualTo "opf_f") exitWith {
    #include "f\briefing\f_briefing_csat.sqf"
};

// ====================================================================================
// BRIEFING: INDEPENDENT > AAF
// The following block of code executes only if the player is in a AAF slot; it automatically includes a file which contains the appropriate briefing data.

if (_unitfaction isEqualTo "ind_f") exitWith {
    #include "f\briefing\f_briefing_aaf.sqf"
};

// ====================================================================================
// BRIEFING: CIVILIAN
// The following block of code executes only if the player is in a CIVILIAN slot; it automatically includes a file which contains the appropriate briefing data.

if (_unitfaction isEqualTo "civ_f") exitWith {
    #include "f\briefing\f_briefing_civ.sqf"
};

// ====================================================================================
// BRIEFING: ZEUS
// The following block of code executes only if the player is in a ZEUS (Gamelogic) slot; it automatically includes a file which contains the appropriate briefing data.

if (_unitfaction isEqualTo "") exitWith {
    #include "f\briefing\f_briefing_zeus.sqf"
};

// ====================================================================================
// ERROR CHECKING
// If the faction of the unit cannot be defined, the script exits with an error.

player globalChat format ["WARNING (briefing.sqf): Faction %1 is not defined.",_unitfaction];