// F3 - GroupMarkers
// Credits: Please see the F3 online manual (http://www.ferstaberinde.com/f3/en/)
/*
	Setup the default groups for a faction
	Paramaters
		0: Side
		1: Bool : Reset ( resets the data )
	Returns
		Nothing
*/
params [["_unitfaction","",[""]],
        ["_reset",false,[true,false]]];
//_unitfaction = toLower ([_this, 0, "",[""]] call BIS_fnc_param);
//_reset = [_this, 1, false,[true,false]] call BIS_fnc_param;

if(_reset) then
{
    f_grpMkr_groups = [];
	// Start with just platoon marker.

	["","1PLT",["1PLT"] call F_fnc_getGroupMarkerStyle,3] call F_fnc_addGroupMarker;
	f_grpMkr_data = [];
	f_grpMkr_id = 0;
};


// ====================================================================================
// Setup Group markers.

// Add the 3 squads, automatic markers requires the groupID function
{
	if(faction (leader _x) == _unitfaction) then
	{
		_split = ([groupID _x," "] call BIS_fnc_splitString);
        _name = _split select ((count _split) - 1);
		_style = [_name] call F_fnc_getGroupMarkerStyle;
        _entity = _x;
        
        switch (true) do {
          case (_name in ["ASL","A1","A2","A3"]):{
              // If no Alpha Squad Marker found already, make one.
              if (count ([f_grpMkr_groups,"A"] call BIS_fnc_findNestedElement) == 0) then {
                  ["1PLT","A",["A"] call F_fnc_getGroupMarkerStyle,1] call F_fnc_addGroupMarker;
              };
			  if (_name == "ASL") then {
				["A",_name,_style,-1,_entity] call F_fnc_addGroupMarker; 
			  } else {
				["A",_name,_style,0,_entity] call F_fnc_addGroupMarker; 
			  };
          };
          case (_name in ["BSL","B1","B2","B3"]):{ 
              // If no Bravo Squad Marker found already, make one.
              if (count ([f_grpMkr_groups,"B"] call BIS_fnc_findNestedElement) == 0) then {
                  ["1PLT","B",["B"] call F_fnc_getGroupMarkerStyle,1] call F_fnc_addGroupMarker;
              };
              if (_name == "BSL") then {
				["B",_name,_style,-1,_entity] call F_fnc_addGroupMarker; 
			  } else {
				["B",_name,_style,0,_entity] call F_fnc_addGroupMarker; 
			  };
          };
          case (_name in ["CSL","C1","C2","C3"]):{
              // If no Charlie Squad Marker found already, make one.
              if (count ([f_grpMkr_groups,"C"] call BIS_fnc_findNestedElement) == 0) then {
                  ["1PLT","C",["C"] call F_fnc_getGroupMarkerStyle,1] call F_fnc_addGroupMarker;
              };
              if (_name == "CSL") then {
				["C",_name,_style,-1,_entity] call F_fnc_addGroupMarker; 
			  } else {
				["C",_name,_style,0,_entity] call F_fnc_addGroupMarker; 
			  };
          };
          default { ["1PLT",_name,_style,-1,_entity] call F_fnc_addGroupMarker;};
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
        ["UnitNATO_SGT_M","SGTM","1PLT"],
		["UnitNATO_WSL_M","WM","1PLT"],
        ["UnitNATO_ASL_M","AM","A"],
        ["UnitNATO_BSL_M","BM","B"],
        ["UnitNATO_CSL_M","CM","C"]
        ];

    };
    case "opf_f": {
        _units = [
        ["UnitCSAT_CO_M","COM","1PLT"],
        ["UnitCSAT_SGT_M","SGTCM","1PLT"],
		["UnitCSAT_WSL_M","WM","1PLT"],
        ["UnitCSAT_ASL_M","AM","A"],
        ["UnitCSAT_BSL_M","BM","A"],
        ["UnitCSAT_CSL_M","CM","A"]
        ];
    };
    case "ind_f": {
        _units = [
        ["UnitAAF_CO_M","COM","1PLT"],
        ["UnitAAF_SGTC_M","SGTCM","1PLT"],
		["UnitAAF_WSL_M","WM","1PLT"],
        ["UnitAAF_ASL_M","AM","A"],
        ["UnitAAF_BSL_M","BM","B"],
        ["UnitAAF_CSL_M","CM","C"]
        ];
    };
    case "blu_g_f": {
        _units = [
        ["UnitFIA_CO_M","COM","1PLT"],
        ["UnitFIA_SGTC_M","SGTCM","1PLT"],
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
        [(_x select 2),(_x select 1),_style,-1,_entity] call F_fnc_addGroupMarker;
    };
} forEach _units;
