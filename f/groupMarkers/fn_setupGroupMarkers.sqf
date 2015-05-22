// F3 - GroupMarkers
// Credits: Please see the F3 online manual (http://www.ferstaberinde.com/f3/en/)
/*
	Setup the default groups for a faction
	Paramaters
		0: Faction
		1: Bool : Reset ( resets the data )
	Returns
		Nothing
*/
private["_unitfaction","_reset","_name","_style","_entity","_units"];

_unitfaction = toLower ([_this, 0, "",[""]] call BIS_fnc_param);
_reset = [_this, 1, false,[true,false]] call BIS_fnc_param;

if(_reset) then {
    f_grpMkr_groups = [];
    
	// Start with just platoon marker.
	["","1PLT",["1PLT"] call F_fnc_getGroupMarkerStyle,3] call f_addon_fnc_addGroupMarker;
};


// ====================================================================================
// Setup Group markers.

if ([_unitfaction,"ASL","A1","A2","A3"] call f_addon_fnc_doGroupsExist) then {
   ["1PLT","A",["A"] call F_fnc_getGroupMarkerStyle,1] call f_addon_fnc_addGroupMarker;  
};
if ([_unitfaction,"BSL","B1","B2","B3"] call f_addon_fnc_doGroupsExist) then {
    ["1PLT","B",["B"] call F_fnc_getGroupMarkerStyle,1] call f_addon_fnc_addGroupMarker;  
};
if ([_unitfaction,"CSL","C1","C2","C3"] call f_addon_fnc_doGroupsExist) then {
    ["1PLT","C",["C"] call F_fnc_getGroupMarkerStyle,1] call f_addon_fnc_addGroupMarker;   
};

// Add the 3 squads, automatic markers requires the groupID function
{
	if(toLower (faction (leader _x)) isEqualTo _unitfaction) then {
        
        _name = ([groupID _x," "] call BIS_fnc_splitString); _name = _name select ((count _name) -1);
		_style = [_name] call F_fnc_getGroupMarkerStyle;
        _entity = _x;
        
        switch (true) do {
            case (_name isEqualTo "ASL"): {
                ["A",_name,_style,-1,_entity] call f_addon_fnc_addGroupMarker; 
            };
            case (_name in ["A1","A2","A3"]):{
                ["A",_name,_style,0,_entity] call f_addon_fnc_addGroupMarker; 
            };
            case (_name isEqualTo "BSL"): {
                ["B",_name,_style,-1,_entity] call f_addon_fnc_addGroupMarker; 
            };
            case (_name in ["B1","B2","B3"]):{
                ["B",_name,_style,0,_entity] call f_addon_fnc_addGroupMarker; 
            };
            case (_name isEqualTo "CSL"): {
                ["C",_name,_style,-1,_entity] call f_addon_fnc_addGroupMarker; 
            };
            case (_name in ["C1","C2","C3"]):{
                ["C",_name,_style,0,_entity] call f_addon_fnc_addGroupMarker; 
            };
          default {
              //For any Group that isn't specified above add them to as a group of the platoon.
              ["1PLT",_name,_style,-1,_entity] call f_addon_fnc_addGroupMarker;
          };
        };
	};
} forEach allGroups;

// ====================================================================================
// Specialist Groups

_units = [];
switch (_unitfaction) do {
    case "blu_f": {
        _units = [
        ["UnitNATO_CO_M","COM","1PLT"],
        ["UnitNATO_DC_M","DCM","1PLT"],
        ["UnitNATO_ASL_M","AM","A"],
        ["UnitNATO_BSL_M","BM","B"],
        ["UnitNATO_CSL_M","CM","C"]
        ];

    };
    case "opf_f": {
        _units = [
        ["UnitCSAT_CO_M","COM","1PLT"],
        ["UnitCSAT_DC_M","DCM","1PLT"],
        ["UnitCSAT_ASL_M","AM","A"],
        ["UnitCSAT_BSL_M","BM","A"],
        ["UnitCSAT_CSL_M","CM","A"]
        ];
    };
    case "ind_f": {
        _units = [
        ["UnitAAF_CO_M","COM","1PLT"],
        ["UnitAAF_DC_M","DCM","1PLT"],
        ["UnitAAF_ASL_M","AM","A"],
        ["UnitAAF_BSL_M","BM","B"],
        ["UnitAAF_CSL_M","CM","C"]
        ];
    };
    case "blu_g_f": {
        _units = [
        ["UnitFIA_CO_M","COM","1PLT"],
        ["UnitFIA_DC_M","DCM","1PLT"],
        ["UnitFIA_ASL_M","AM","A"],
        ["UnitFIA_BSL_M","BM","B"],
        ["UnitFIA_CSL_M","CM","C"]
        ];
    };
};

{
    _entity = missionNamespace getVariable[(_x select 0),objNull];
    if (!isNull _entity) then {
        _style = [_x select 1] call F_fnc_getGroupMarkerStyle;
        [(_x select 2),(_x select 1),_style,-1,_entity] call f_addon_fnc_addGroupMarker;
    };
} forEach _units;
