params["_mapControl"];
//DEBUG
//_text = format["scale %1 dist %2",(ctrlMapScale _mapControl),(_mapControl posWorldToScreen ((f_grpMkr_groups select 0) select 5)) distance (_mapControl posWorldToScreen ((f_grpMkr_groups select 1) select 5))];
//_mapControl drawIcon["\A3\ui_f\data\map\markers\military\dot_CA.paa",[1,1,1,1],[0,0,0],24,24,0,_text,2,0.05];

//Fireteam markers.
if ((ctrlMapScale _mapControl) < 0.4) then {
    if (!isNil "f_ftMkr_data") then {
        {
			_x params ["_pos","_dir","_color"];
            _mapControl drawIcon["\A3\ui_f\data\map\markers\military\triangle_CA.paa",[0,0,0,0.5],_pos,24,24,_dir]; // black border
            _mapControl drawIcon["\A3\ui_f\data\map\markers\military\triangle_CA.paa",_color,_pos,16,16,_dir];

        } forEach (f_ftMkr_data);
    };
};


//_text = format["time %1",diag_tickTime - _start];
//_mapControl drawIcon["\A3\ui_f\data\map\markers\military\dot_CA.paa",[1,1,1,1],[0,0,0],24,24,0,_text,2,0.05];

//Group Markers.
[f_grpMkr_groups,_mapControl] call f_fnc_drawGroupMarkerRec;