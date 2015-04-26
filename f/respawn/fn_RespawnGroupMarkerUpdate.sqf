// Goes through f_respawnedGroupsMarkerData, ensuring all groups already have markers.
if (isNil "f_respawnedGroupsMarkerData") exitWith {};

{
    //Check if Group already has a group marker.
    if (!isNil (_x select 0)) then {
        _found = false;

        //Check if the entity is already setup to be drawn (aka in f_grpMkr_groups)
        _entity = call compile format ["%1",_x select 0];
        
        _found = (count ([f_grpMkr_groups,_entity] call BIS_fnc_findNestedElement) != 0);

        //If not add the new group.
        if (!_found) then {
          //Check if we should be adding the group.
            _toAdd = false;
            if(typeName _entity == "GROUP") then {
                _toAdd = faction player == faction leader _entity;
            } else {
                _toAdd = faction player == faction _entity;
            };

            if (_toAdd) then {
                // New F3 marker system.
                _markerTexture = ((respawnMenuMarkers select (_x select 2)) select 0);
                _markerColorRGB = (respawnMenuMarkerColours select (_x select 3)) select 0;

                //[_groupVarName,_markerName,_markerType,_markerColor]
                //[_entity, _x select 1,  _markerTexture,_markerColorRGB] call F_fnc_addGroupMarker;
                ["",(_x select 1),[_markerTexture,_markerColorRGB,[24,24]],-1,_entity] call F_fnc_addGroupMarker;
            };
        };
    };
} forEach f_respawnedGroupsMarkerData;