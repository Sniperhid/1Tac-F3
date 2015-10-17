// RESPAWN WAVE SERVER FUNCTION
//
// This function initiates the group respawn, sending the data to each client to start the respawn
// The actual group will be created on the leader's client and then broadcast to everyone.
// This code will then wait for that group to return before then notifying all clients of the new group marker.
//

params ["_groupName", "_position", "_faction", "_selectedRespawnGroup", "_markerType", "_markerColor", "_markerName", "_halo"];

// Loop through each proposed client for respawn.
{
    if (_halo) then {
        _position = _position vectorAdd [10,0,0]; // do position transofmration
    } else {
        _position = _position vectorAdd [1,0,0]; // do position transofmration
    };
    
    _x params ["_rank", "_client", "_typeOfUnit"];
    _leader = _forEachIndex==0;


    [[f_serverRespawnGroupCounter,
      _position,
      _faction,
      _typeOfUnit,
      _rank,
      f_serverRespawnPlayerCounter,
      _leader,_halo],
      "F_fnc_RespawnLocalClient", _client] call BIS_fnc_MP;
    
    //Setup respawned player to die if he disconnects?
    [f_serverRespawnPlayerCounter] spawn {
        private["_unitName", "_unit"];
        sleep 5;
        _unitName = format["respawnedUnit%1",(_this select 0)];
        waitUntil{sleep 3;!isNil _unitName};
        _unit = missionNamespace getVariable[_unitName,objNull];
        while{true} do {
            if (isNull _unit) exitWith {};
            if (!isPlayer _unit) exitWith {
                _unit setDamage 1;
                [_unit] join grpNull;
            };
            sleep 5;
        };
    };
    f_serverRespawnPlayerCounter = f_serverRespawnPlayerCounter + 1;
} forEach _selectedRespawnGroup;

_groupVarName = format ["GrpRespawn_%1",f_serverRespawnGroupCounter];
f_serverRespawnGroupCounter = f_serverRespawnGroupCounter + 1;

[_groupVarName,_markerType,_markerName,_markerColor,_faction] spawn {
    params["_groupVarName","_markerType","_markerName","_markerColor","_faction"];

    waitUntil{!isNil _groupVarName};

    sleep 2; // Give some time to allow clients time to make their players transfer across the network.

    //Check if a marker was requested before sending to all clients to be created.
    if (_markerType != -1) then {        
        
        //
        // Garbage collector: Cleanup f_respawnedGroupsMarkerData of old invalid groups.
        //
        
        _x = 0;
        _length = count f_respawnedGroupsMarkerData;
        while {_x < _length} do {
            // 0 for target, 0 for s
            _entry = f_respawnedGroupsMarkerData select _x;
            _toRemove = false;
            if (isNil (_entry select 0)) then {
                _toRemove = true;   
            } else {
                _entity = missionNamespace getVariable [(_entry select 0),objNull];
                if (isNull _entity) then {
                    _toRemove = true;   
                } else {
                    if (!isNull leader _entity) then {
                        _toRemove = false;
                        //FUTURE consider removing group if the leader is dead.
                    } else {
                        _toRemove = true;  
                    };
                };
            };

            if (_toRemove) then {
                f_respawnedGroupsMarkerData deleteAt _x;
                 _x = _x - 1; 
                _length = _length - 1;
            };
            _x = _x + 1;
        };

        //Add the group marker data for the new group.
        f_respawnedGroupsMarkerData pushBack [_groupVarName,_markerName,_markerType,_markerColor];

        //Broadcast the respawn group data to all clients.
        publicVariable "f_respawnedGroupsMarkerData";

        //PublicVariable handler won't be called on the host if non-dedicated.
        if (isServer && !isDedicated) then {
            [] call F_fnc_RespawnGroupMarkerUpdate;
        };
    };
};


_selectedRespawnGroup = nil;