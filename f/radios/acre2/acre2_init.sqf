// F3 - ACRE2 Init
// Credits: Please see the F3 online manual (http://www.ferstaberinde.com/f3/en/)
// ====================================================================================

// precompile functions
f_acre2_clientInit = compile preprocessFileLineNumbers "f\radios\acre2\acre2_clientInit.sqf";
f_acre2_createPresets = compile preprocessFileLineNumbers "f\radios\acre2\acre2_createPresets.sqf";


// include the smaller acre2 settings file.
#include "acre2_settings.sqf"

// Check null settings
if (isNil "f_radios_settings_acre2_languages") then {
    f_radios_settings_acre2_languages = [["english","English"]];
};
if (isNil "f_radios_settings_acre_babel_assignment") then {
    f_radios_settings_acre_babel_assignment = { ["english"] };  
};
if (isNil "f_radios_settings_acre2_disableRadios") then {
    f_radios_settings_acre2_disableRadios = false;
};
if (isNil "f_radios_settings_acre2_allocation") then {
    f_radios_settings_acre2_allocation = {[] };  
};
if (isNil "f_radios_settings_acre2_radioChannels") then {
    f_radios_settings_acre2_radioChannels = [];  
};
if (isNil "f_radios_settings_acre2_special_radioChannels") then {  
    f_radios_settings_acre2_special_radioChannels = [];
};
if (isNil "f_radios_settings_giveMissingRadios") then {
    f_radios_settings_giveMissingRadios = false;
};
if (isNil "f_radios_settings_acre2_addActionRadios") then {
    f_radios_settings_acre2_addActionRadios = [];  
};
if (isNil "f_radios_settings_acre2_radioSettings") then {
    f_radios_settings_acre2_radioSettings = [
		// Array of Radio names, min freq, max freq, freq step, freq spacing between channels (for channel alloication
		[["ACRE_PRC343"],2400,2420,0.01,0.1,"default2"],
		[["ACRE_PRC148","ACRE_PRC152","ACRE_PRC117F"],30,300,0.00625,1,"default"]//,
	];
};
    

f_factionNameToSimpleName = {
	private["_factionName","_factionStr"];
	_factionName = toLower(_this select 0);
	_factionStr = switch (_factionName) do {
		case "blu_f": {"NATO"};
		case "opf_f": {"CSAT"};
		case "ind_f": {"AAF"};
		case "blu_g_f": {"FIA"};
		case "opf_g_f": {"OFIA"};
		case "ind_g_f": {"IFIA"};
		default {""};
	};  
	_factionStr
};

f_isUnitInGroupArray = {
	private["_ret","_i","_factionStr","_grpString","_grp"];
	_ret = false;
	params["_unit"];
	_factionStr = [faction _unit] call f_factionNameToSimpleName;
    _grpString = ("Grp" + _factionStr  + "_");
	for "_i" from 1 to ((count _this)-1) step 1 do {
        if (group _unit == missionNamespace getVariable[_grpString + (_this select _i),grpNull]) exitWith { _ret = true; };
	};
	_ret
};

f_isUnitLeaderInGroupArray = {
	private["_ret","_i","_factionStr","_grpString","_grp"];
	_ret = false;
	params["_unit"];
	_factionStr = [faction _unit] call f_factionNameToSimpleName;
    _grpString = ("Grp" + _factionStr  + "_");
	for "_i" from 1 to ((count _this)-1) step 1 do {
        if (group _unit == missionNamespace getVariable[_grpString + (_this select _i),grpNull]) exitWith { 
            if (leader group _unit == _unit) then { _ret = true; };
        };
	};
	_ret
};

f_isUnitinUnitArray = {
	private["_unitStr","_i","_ret","_factionStr"];
	params["_unit"];
	_unitStr = (str _unit);
	_ret = false;
	_factionStr = [faction _unit] call f_factionNameToSimpleName;
	for "_i" from 1 to ((count _this)-1) step 1 do {
		if (_unitStr == format["Unit%1_%2",_factionStr,(_this select _i)]) exitWith {_ret = true };
	};
	_ret
};


if (isServer) then {
	f_radios_settings_acre2_freqOffsets = [];

	if (!isNil "f_radios_settings_acre2_radioChannels") then { 
		{   
			f_radios_settings_acre2_freqOffsets pushBack (random 1);
		} forEach f_radios_settings_acre2_radioChannels;
		f_radios_settings_acre2_freqOffsets pushBack (random 1); // add default channel split
		{
			f_radios_settings_acre2_freqOffsets pushBack (random 1); // add default channel split
		} forEach (f_radios_settings_acre2_special_radioChannels);
	};

	publicVariable "f_radios_settings_acre2_freqOffsets";
};

waitUntil{!isNil "f_radios_settings_acre2_freqOffsets"}; // wait to recieve from server.
[] call f_acre2_createPresets;

// run client stuff.
if(hasInterface) then
{
	// define our languages (need to be the same order for everyone)
	{
		_x call acre_api_fnc_babelAddLanguageType;
	} forEach f_radios_settings_acre2_languages;

    if (didJIP) then {
        uiSleep 5;
        waitUntil {uiSleep 0.1; !isNull player};
    };

    
	[] call f_acre2_clientInit;
};