private ["_parent","_ourName","_style","_gSize","_entity","_line","_place","_subArray","_pos"];
// Function to add groupMarkers to the F3 group marker system.

_parent = _this select 0;
_ourName = _this select 1;
_style = _this select 2;
_gSize = _this select 3;
_entity = objNull;
if (count _this > 4) then {
    _entity = _this select 4;
};

// MAXDISTPOST -> furtherest away child from mean, MinDistPos -> Closest sibling
// NAME, TEXTURE, COLOUR, SIZE, POS, MINDISTPO (neighoubrS, MAXDISTPOS (neighbour), RANK, <ENTITY>
_line = [_ourName,_style select 0,_style select 1,_style select 2,[0,0,0],[0,0,0],[0,0,0],_gSize];

if (!isNull _entity) then {
    _line pushBack _entity;
    _pos = [0,0,0];
    if(typeName _entity == "GROUP") then {_pos = getPos leader _entity};
    if(typeName _entity == "OBJECT") then {_pos = getPos _entity};
    _line set [4,_pos];
};

_place = [f_grpMkr_groups,_parent] call BIS_fnc_findNestedElement;
if (count _place == 0) then {
	if (count f_grpMkr_groups == 0) then {
		f_grpMkr_groups pushBack _line;
	} else {
		f_grpMkr_groups pushBack [_line];
	};
} else {
    _subArray = f_grpMkr_groups;
    for "_i" from 0 to ((count _place)-3) do {
        _subArray = _subArray select (_place select _i);
    };
    _subArray pushBack [_line];
};
