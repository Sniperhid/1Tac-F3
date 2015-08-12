// F3 - ORBAT Notes
// Credits: Please see the F3 online manual (http://www.ferstaberinde.com/f3/en/)
// ====================================================================================

// Define needed variables

if (!hasInterface) exitWith {};
private["_group","_color","_icon","_unitLine","_weaponIcon"];

uiSleep 5;

_orbatBriefingContents =  format ["Note: This is only valid at mission start.<br/><font size='18'>ORBAT Summary:</font><br/>"];

_summaryGroupListing = "<font size='12'>";
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
                _summaryGroupListing = _summaryGroupListing + format["<font color='#f7da00'>%1 - %2</font><br/>", (groupID _group), name (leader _group)];
            } else {
                _summaryGroupListing = _summaryGroupListing + format["%1 - %2<br/>", (groupID _group), name (leader _group)];
            };

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

_orbatBriefingContents = _orbatBriefingContents + _summaryGroupListing + "</font><br/><font size='18'>Full ORBAT:</font><br/>" + _fullGroupListing;

waitUntil {scriptDone f_script_briefing};
player createDiaryRecord ["diary", ["ORBAT", _orbatBriefingContents]];
