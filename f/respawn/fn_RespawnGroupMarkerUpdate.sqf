// Goes through f_respawnedGroupsMarkerData, ensuring all groups already have markers.
if (isNil "f_respawnedGroupsMarkerData") exitWith {};

private["_entity","_found","_toAdd","_markerTexture","_markerColorRGB"];

{
    //Check if Group already has a group marker.
    if (!isNil (_x select 0)) then {
        _found = false;

        //Check if the entity is already setup to be drawn (aka in f_grpMkr_groups)
        _entity = missionNamespace getVariable[(_x select 0),objNull];
        
        _found = (count ([f_grpMkr_groups,_entity] call BIS_fnc_findNestedElement) != 0);

        //If not add the new group.
        if (!_found) then {
          //Check if we should be adding the group.
            _toAdd = false;
            if(_entity isEqualType grpNull) then {
                _toAdd = faction player == faction leader _entity;
            } else {
                _toAdd = faction player == faction _entity;
            };

            if (_toAdd) then {
                // New F3 marker system.
                _markerTexture = ((respawnMenuMarkers select (_x select 2)) select 0);
                _markerColorRGB = (respawnMenuMarkerColours select (_x select 3)) select 0;
                _size = [28,28];
                
                if (f_groupMarkers_pboLoaded) then {
                    _color = ((respawnMenuMarkerColours select (_x select 3)) select 2);
                    _type = ((respawnMenuMarkers select (_x select 2)) select 2);
                    _markerTexture = "\f3_groupmarkers\textures\" + _color + "_" + _type;
                    _markerColorRGB = [1,1,1,1];
                    _size = [32,32];
                };

                ["1PLT",(_x select 1),[_markerTexture,_markerColorRGB,_size],-1,_entity] call F_fnc_addGroupMarker;
            };
        };
    };
} forEach f_respawnedGroupsMarkerData;