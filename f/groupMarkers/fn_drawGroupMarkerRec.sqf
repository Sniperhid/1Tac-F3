private["_hasChildren","_drawMe","_minSiblingDist","_maxChildCenterDist","_myPos"];
params["_in","_mapControl"];

_in params ["_rootData"];
_hasChildren = count _in > 1;
_drawMe = !_hasChildren; // no children = draw me.

//Calculate the distances using the cached postions.
_myPos = _mapControl posWorldToScreen (_rootData select 4);
_minSiblingDist = _myPos distanceSqr (_mapControl posWorldToScreen (_rootData select 5));

if (_hasChildren) then {
    _maxChildCenterDist = _myPos distanceSqr (_mapControl posWorldToScreen (_rootData select 6));
    if (_maxChildCenterDist < 0.0025) then {
        _drawMe = true;  
    };
};

// Draw this.
if (_drawMe) then {
    private["_gTexture"];
	_rootData params ["_text","_texture","_color","_size","_pos"];

	if (f_groupMarkers_pboLoaded) then {
		_gTexture = switch (_rootData select 7) do {
		  case 0:{"\f3_groupmarkers\textures\modif_o.paa"};  // fireteam
		  case 1:{"\f3_groupmarkers\textures\modif_dot.paa"}; // squad/section
		  case 2:{"\f3_groupmarkers\textures\modif_2dot.paa"}; // 2 squads/half platoon
		  case 3:{"\f3_groupmarkers\textures\modif_3dot.paa"}; // platoon
		  default {""};
		};
	} else {
		_gTexture = switch (_rootData select 7) do {
		  case 0:{"\A3\ui_f\data\map\markers\nato\group_0.paa"}; // fireteam
		  case 1:{"\A3\ui_f\data\map\markers\nato\group_1.paa"}; // squad/section
		  case 2:{"\A3\ui_f\data\map\markers\nato\group_2.paa"}; // 2 squads/half platoon
		  case 3:{"\A3\ui_f\data\map\markers\nato\group_3.paa"}; // platoon
		  default {""};
		};
	};
	_textSize = 0.035;
	if (_minSiblingDist < 0.0014) then {_textSize = 0}; //0.0014

	_mapControl drawIcon["#(argb,8,8,3)color(0,0,0,0)",[1,1,1,1],_pos,(_size select 0),(_size select 1),0,_text,2,_textSize,'PuristaSemibold','right'];//PuristaBold
	_mapControl drawIcon[_texture,_color,_pos,(_size select 0),(_size select 1),0];
	
	if (_gTexture != "") then {
		_mapControl drawIcon[_gTexture,[1,1,1,1],_pos,(_size select 0),(_size select 1),0,"",0];  
	};
} else { // Draw the children instead.
	for "_i" from 1 to (count _in - 1) do {
		[(_in select _i),_mapControl] call f_fnc_drawGroupmarkerRec; 
	};
};