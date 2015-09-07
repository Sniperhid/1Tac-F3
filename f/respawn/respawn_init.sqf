
// Include the file settings.
#include "respawn_settings.sqf"

// Include the GUI code with all the GUI control event handlers.
#include "respawn_gui_code.sqf";

// SERVER INIT

if (isServer) then {
    
    //Counters to allow for unique IDs of respawned players and groups.
    f_serverRespawnPlayerCounter = 1;
    f_serverRespawnGroupCounter = 1;

    //Stores the marker information for all respawned groups
    f_respawnedGroupsMarkerData = [];
};

// CLIENT INIT

if (hasInterface) then {
    
    // Add a eventhandler to await for respawned group marker data.
    if (!isNil "f_script_setGroupMarkers") then {
        "f_respawnedGroupsMarkerData" addPublicVariableEventHandler {
            [] call F_fnc_RespawnGroupMarkerUpdate;
        };

        waitUntil{scriptDone f_script_setGroupMarkers}; // Wait till the group marker componeny has setup its event 
		
		// Create markers for any respawned markers that have occured before the client has joined.
		[] call F_fnc_RespawnGroupMarkerUpdate;
    };
};
