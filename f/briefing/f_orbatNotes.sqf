// F3 - ORBAT Notes
// Credits: Please see the F3 online manual (http://www.ferstaberinde.com/f3/en/)
// ====================================================================================

// Define needed variables
/*
private ["_orbatText", "_groups", "_precompileGroups","_maxSlots","_freeSlots"];
_orbatText = "<br />NOTE: The ORBAT below is only accurate at mission start.<br />
<br />
<font size='18'>GROUP LEADERS + MEDICS</font><br /><br />";
_groups = [];
_hiddenGroups = [];

{
	// Add to ORBAT if side matches, group isn't already listed, and group has players
	if ((side _x == side group player) && !(_x in _groups) && ({_x in playableUnits} count units _x) > 0) then {
	//if ((side _x == side group player) && !(_x in _groups)) then {
		_groups pushBack _x;
	};
} forEach allGroups;

// Remove groups we don't want to show
_groups = _groups - _hiddenGroups;

// Loop through the group, print out group ID, leader name and medics if present
{
	// Highlight the player's group with a different color (based on the player's side)
	_color = "#FFFFFF";
	if (_x == group player) then {
		_color = switch (side player) do {
			 case west: {"#0080FF"};
			 case east: {"#B40404"};
			 case independent: {"#298A08"};
			 default {"#8904B1"};
 		};
	};

	_orbatText = _orbatText + format ["<font color='%3'>%1 %2</font>", _x, name leader _x,_color] + "<br />";

	{
		if (_x getVariable ["f_var_assignGear",""] == "m" && {_x != leader group _x}) then {
			_orbatText = _orbatText + format["|- %1 [M]",name _x] + "<br />";
		};
	} forEach units _x;
} forEach _groups;

_veharray = [];
{

	if ({vehicle _x != _x} count units _x > 0 ) then {
		{
			if (vehicle _x != _x && {!(vehicle _x in _veharray)}) then {
			_veharray set [count _veharray,vehicle _x];
			};
		} forEach units _x;
	};

} forEach _groups;

if (count _veharray > 0) then {

_orbatText = _orbatText + "<br />VEHICLE CREWS + PASSENGERS<br />";

	{
		 // Filter all characters which might break the diary entry (such as the & in Orca Black & White)
		_vehName = [getText (configFile >> "CfgVehicles" >> (typeOf _x) >> "displayname"),"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_- "] call BIS_fnc_filterString;

		_orbatText = _orbatText + "<br />" + format["%1 ",_vehName];

		count allTurrets [_x, true] - count allTurrets _x;

		// Workaround for http://feedback.arma3.com/view.php?id=21602
		_maxSlots = getNumber(configfile >> "CfgVehicles" >> typeof _x >> "transportSoldier") + (count allTurrets [_x, true] - count allTurrets _x);
		_freeSlots = _x emptyPositions "cargo";

		if (_maxSlots > 0) then {
			_orbatText = _orbatText + format ["[%1/%2]",(_maxSlots-_freeSlots),_maxSlots];
		};

		_orbatText = _orbatText  + "<br />";

		{
			if ((assignedVehicleRole _x select 0) != "CARGO") then {
				_orbatText = _orbatText + format["|- %1",name _x];
				if (driver vehicle _x == _x) exitWith {_orbatText =_orbatText +" [D] <br />"};
				if (gunner vehicle _x == _x) exitWith {_orbatText =_orbatText +" [G] <br />"};
				if (commander vehicle _x == _x) exitWith {_orbatText =_orbatText +" [C] <br />"};
				_orbatText =_orbatText +" [G] <br />"
			};
		} forEach crew _x;

		_groupList = [];

		{
			if (!(group _x in _groupList) && {(assignedVehicleRole _x select 0) == "CARGO"} count (units group _x) > 0) then {
				_groupList set [count _groupList,group _x];
			};
		} forEach crew _x;

		if (count _groupList > 0) then {
			{
				_orbatText =_orbatText + format["|- %1", _x] + " Passengers <br />";
			} forEach _groupList;
		};

	} forEach _veharray;

};*/


[] spawn {
    uiSleep 5;

    _orbatBriefingContents =  format ["Note: This is only valid at mission start.<br/><font size='18'>ORBAT Summary:</font><br/>"];
	
	_summaryGroupListing = "";
	_fullGroupListing = "";
    {
		_group = _x;
        if (({_x in (playableUnits+switchableUnits)} count (units _group)) > 0) then { //isPlayer 
            if ((faction (leader _group)) isEqualTo (faction player)) then {
                _color = switch (side _x) do {
                case (west): {"#0088EE"};//0,0.45,0.9,1
                case (east): {"#DD0000"};//[0.75,0,0,1]
                case (resistance): {"#00DD00"};//[0,0.75,0,1]
                case (civilian): {"#880099"};//[0.6,0,0.75,1]
                    default {"#FFFFFF"};
                };
				//_color = "#FFFFFF";
				if (_group == group player) then {
					_color = "#f7da00";
				};
				_summaryGroupListing = _summaryGroupListing + format["<font size='12'>%1 - %2</font><br/>", (groupID _group), name (leader _group)];
				
                _fullGroupListing = _fullGroupListing + format ["<br/><font color='%1' size='20'>%2</font><br/>", _color, (groupID _group)];
                {
                    _icon = getText (configFile >> "CfgVehicleIcons" >> getText (configFile >> "CfgVehicles" >> (typeOf _x) >> "icon"));
					_weaponIcon = "";
					if (currentWeapon _x != "") then {
						_weaponIcon = getText(configFile >> "CfgWeapons" >> (currentWeapon _x) >> "picture");
                        if (_weaponIcon find ".paa" == -1) then { _weaponIcon = _weaponIcon + ".paa"};
					};
                    _unitLine = format ["<img image='%1' height='18'/> <font size='14'>%2</font> <img image='%3' height='32'/>", _icon, (name _x),_weaponIcon];
					if (secondaryWeapon _x != "") then {
						_weaponIcon = "";
						_weaponIcon = getText(configFile >> "CfgWeapons" >> (secondaryWeapon _x) >> "picture");
                        if (_weaponIcon find ".paa" == -1) then { _weaponIcon = _weaponIcon + ".paa"};
						_unitLine = _unitLine + format["<img image='%1' height='32'/>",_weaponIcon];
					};
					
					if (_x == player) then {
						_unitLine = "<font color='#f7da00'>" + _unitLine + "</font>";
					};
					 _fullGroupListing = _fullGroupListing + (_unitLine + "<br/>");
                } forEach (units _group);
            };
        };
    } forEach allGroups;

	_orbatBriefingContents = _orbatBriefingContents + _summaryGroupListing + "<br/><font size='18'>Full ORBAT:</font><br/>" + _fullGroupListing;
	
	waitUntil {scriptDone f_script_briefing};
    player createDiaryRecord ["diary", ["ORBAT", _orbatBriefingContents]];
};

