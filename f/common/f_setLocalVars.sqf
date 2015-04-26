// F3 - F3 Common Local Variables
// Credits: Please see the F3 online manual (http://www.ferstaberinde.com/f3/en/)
// ====================================================================================

// ====================================================================================
// DEBUG DEFINES

#define SLV_NAME "(f\common\f_setLocalVars.sqf)"
#define DEBUG_OUTPUT player sidechat

// DECLARE VARIABLES AND FUNCTIONS
private ["_str_f_param_units","_str_f_param_units_BLU","_str_f_param_units_RES","_str_f_param_units_OPF","_str_f_param_units_CIV","_str_f_param_men","_str_f_param_men_BLU","_str_f_param_men_RES","_str_f_param_men_OPF","_str_f_param_men_CIV","_str_f_param_groups_BLU","_str_f_param_groups_RES","_str_f_param_groups_OPF","_str_f_param_groups_CIV","_str_f_param_groups","_str_f_param_vehicles","_str_f_param_vehicles_BLU","_str_f_param_vehicles_RES","_str_f_param_vehicles_OPF","_str_f_param_vehicles_CIV"];

// ====================================================================================

// COMMON VARIABLE: f_param_units
// We will create an array containing all units.

f_param_units = allUnits + vehicles;

// DEBUG
if (f_param_debugMode == 1) then
{
	_str_f_param_units = str f_param_units;
	DEBUG_OUTPUT format ["DEBUG %2: f_param_units = %1", _str_f_param_units, SLV_NAME];
};

// ====================================================================================

// COMMON VARIABLE: f_param_units_BLU
// Using f_param_units we will create an array containing all BLUFOR units.

f_param_units_BLU = [];
{if ((side _x) == west ) then {f_param_units_BLU = f_param_units_BLU + [_x]}} forEach f_param_units;

// DEBUG
if (f_param_debugMode == 1) then
{
	_str_f_param_units_BLU = str f_param_units_BLU;
	DEBUG_OUTPUT format ["DEBUG %2: f_param_units_BLU = %1",_str_f_param_units_BLU, SLV_NAME];
};

// ====================================================================================

// COMMON VARIABLE: f_param_units_RES
// Using f_param_units we will create an array containing all resistance units.

f_param_units_RES = [];
{if ((side _x) == resistance) then {f_param_units_RES = f_param_units_RES + [_x]}} forEach f_param_units;

// DEBUG
if (f_param_debugMode == 1) then
{
	_str_f_param_units_RES = str f_param_units_RES;
	DEBUG_OUTPUT format ["DEBUG %2: f_param_units_RES = %1",_str_f_param_units_RES, SLV_NAME];
};

// ====================================================================================

// COMMON VARIABLE: f_param_units_OPF
// Using f_param_units we will create an array containing all OPFOR units.

f_param_units_OPF = [];
{if ((side _x) == east) then {f_param_units_OPF = f_param_units_OPF + [_x]}} forEach f_param_units;

// DEBUG
if (f_param_debugMode == 1) then
{
	_str_f_param_units_OPF = str f_param_units_OPF;
	DEBUG_OUTPUT format ["DEBUG %2: f_param_units_OPF = %1",_str_f_param_units_OPF, SLV_NAME];
};

// ====================================================================================

// COMMON VARIABLE: f_param_units_CIV
// Using f_param_units we will create an array containing all civilian units.

f_param_units_CIV = [];
{if ((side _x) == civilian) then {f_param_units_CIV = f_param_units_CIV + [_x]}} forEach f_param_units;

// DEBUG
if (f_param_debugMode == 1) then
{
	_str_f_param_units_CIV = str f_param_units_CIV;
	DEBUG_OUTPUT format ["DEBUG %2: f_param_units_CIV = %1",_str_f_param_units_CIV, SLV_NAME];
};

// ====================================================================================

// COMMON VARIABLE: f_param_men
// Using the master trigger we will create an array containing all men.

f_param_men = [];
{
	if ((_x isKindOf "CAManBase")) then
	{
		f_param_men = f_param_men + [_x]
	};
} forEach f_param_units;

// DEBUG
if (f_param_debugMode == 1) then
{
	_str_f_param_men = str f_param_men;
	DEBUG_OUTPUT format ["DEBUG %2: f_param_men = %1",_str_f_param_men, SLV_NAME];
};

// ====================================================================================

// COMMON VARIABLE: f_param_men_BLU
// Using f_param_men we will create an array containing all BLUFOR men.

f_param_men_BLU = [];
{if ((side _x) == west) then {f_param_men_BLU = f_param_men_BLU + [_x]}} forEach f_param_men;

// DEBUG
if (f_param_debugMode == 1) then
{
	_str_f_param_men_BLU = str f_param_men_BLU;
	DEBUG_OUTPUT format ["DEBUG %2: f_param_men_BLU = %1",_str_f_param_men_BLU, SLV_NAME];
};

// ====================================================================================

// COMMON VARIABLE: f_param_men_RES
// Using f_param_men we will create an array containing all resistance men.

f_param_men_RES = [];
{if ((side _x) == resistance) then {f_param_men_RES = f_param_men_RES + [_x]}} forEach f_param_men;

// DEBUG
if (f_param_debugMode == 1) then
{
	_str_f_param_men_RES = str f_param_men_RES;
	DEBUG_OUTPUT format ["DEBUG %2: f_param_men_RES = %1",_str_f_param_men_RES, SLV_NAME];
};

// ====================================================================================

// COMMON VARIABLE: f_param_men_OPF
// Using f_param_men we will create an array containing all OPFOR men.

f_param_men_OPF = [];
{if ((side _x) == east) then {f_param_men_OPF = f_param_men_OPF + [_x]}} forEach f_param_men;

// DEBUG
if (f_param_debugMode == 1) then
{
	_str_f_param_men_OPF = str f_param_men_OPF;
	DEBUG_OUTPUT format ["DEBUG %2: f_param_men_OPF = %1",_str_f_param_men_OPF, SLV_NAME];
};

// ====================================================================================

// COMMON VARIABLE: f_param_men_CIV
// Using f_param_men we will create an array containing all civilian men.

f_param_men_CIV = [];
{if ((side _x) == civilian) then {f_param_men_CIV = f_param_men_CIV + [_x]}} forEach f_param_men;

// DEBUG
if (f_param_debugMode == 1) then
{
	_str_f_param_men_CIV = str f_param_men_CIV;
	DEBUG_OUTPUT format ["DEBUG %2: f_param_men_CIV = %1",_str_f_param_men_CIV, SLV_NAME];
};

// ====================================================================================

// COMMON VARIABLE: f_param_men_players
// Using f_param_men we will create an array containing all players.

f_param_men_players = [];
{if (isPlayer _x) then {f_param_men_players = f_param_men_players + [_x]}} forEach f_param_men;

// DEBUG
if (f_param_debugMode == 1) then
{
	_str_f_param_men_players = str f_param_men_players;
	DEBUG_OUTPUT format ["DEBUG %2: f_param_men_players = %1",_str_f_param_men_players, SLV_NAME];
};

// ====================================================================================

// COMMON VARIABLE: f_param_groups_BLU
// Using f_param_units_BLU we will create an array containing all BLUFOR groups.

f_param_groups_BLU = [];
{if (!((group _x) in f_param_groups_BLU)) then {f_param_groups_BLU = f_param_groups_BLU + [group _x]}} forEach f_param_units_BLU;

// DEBUG
if (f_param_debugMode == 1) then
{
 	_str_f_param_groups_BLU = str f_param_groups_BLU;
 	DEBUG_OUTPUT format ["DEBUG %2: f_param_groups_BLU = %1",_str_f_param_groups_BLU, SLV_NAME];
};

// ====================================================================================

// COMMON VARIABLE: f_param_groups_RES
// Using f_param_units_RES we will create an array containing all resistance groups.

f_param_groups_RES = [];
{if (!((group _x) in f_param_groups_RES)) then {f_param_groups_RES = f_param_groups_RES + [group _x]}} forEach f_param_units_RES;

// DEBUG
if (f_param_debugMode == 1) then
{
 	_str_f_param_groups_RES = str f_param_groups_RES;
 	DEBUG_OUTPUT format ["DEBUG %2: f_param_groups_RES = %1",_str_f_param_groups_RES, SLV_NAME];
};

// ====================================================================================

// COMMON VARIABLE: f_param_groups_OPF
// Using f_param_units_OPF we will create an array containing all OPFOR groups.

f_param_groups_OPF = [];
{if (!((group _x) in f_param_groups_OPF)) then {f_param_groups_OPF = f_param_groups_OPF + [group _x]}} forEach f_param_units_OPF;

// DEBUG
if (f_param_debugMode == 1) then
{
 	_str_f_param_groups_OPF = str f_param_groups_OPF;
 	DEBUG_OUTPUT format ["DEBUG %2: f_param_groups_OPF = %1",_str_f_param_groups_OPF, SLV_NAME];
};

// ====================================================================================

// COMMON VARIABLE: f_param_groups_CIV
// Using f_param_units_CIV we will create an array containing all civilian groups.

f_param_groups_CIV = [];
{if (!((group _x) in f_param_groups_CIV)) then {f_param_groups_CIV = f_param_groups_CIV + [group _x]}} forEach f_param_units_CIV;

// DEBUG
if (f_param_debugMode == 1) then
{
 	_str_f_param_groups_CIV = str f_param_groups_CIV;
 	DEBUG_OUTPUT format ["DEBUG %2: f_param_groups_CIV = %1",_str_f_param_groups_CIV, SLV_NAME];
};

// ====================================================================================

// COMMON VARIABLE: f_param_groups
// We will create an array containing all groups.

f_param_groups = allGroups;

// DEBUG
if (f_param_debugMode == 1) then
{
 	_str_f_param_groups = str f_param_groups;
 	DEBUG_OUTPUT format ["DEBUG %2: f_param_groups = %1",_str_f_param_groups, SLV_NAME];
};

// ====================================================================================

// COMMON VARIABLE: f_param_groups_players
// We will create an array containing all groups with at least one player.

f_param_groups_players = [];
{
	_units = units _x;
	if ({isPlayer _x} count _units >= 1) then {
		f_param_groups_players set [count f_param_groups_players,_x];
	};
} forEach f_param_groups;

// DEBUG
if (f_param_debugMode == 1) then
{
 	_str_f_param_groups = str f_param_groups;
 	DEBUG_OUTPUT format ["DEBUG %2: f_param_groups = %1",_str_f_param_groups, SLV_NAME];
};


// ====================================================================================

// COMMON VARIABLE: f_param_vehicles
// We will create an array containing all vehicles.

f_param_vehicles = vehicles;

// DEBUG
if (f_param_debugMode == 1) then
{
	_str_f_param_vehicles = str f_param_vehicles;
	DEBUG_OUTPUT format ["DEBUG %2: f_param_vehicles = %1",_str_f_param_vehicles, SLV_NAME];
};

// ====================================================================================

// COMMON VARIABLE: f_param_vehicles_BLU
// Using f_param_vehicles we will create an array containing all BLUFOR vehicles.

f_param_vehicles_BLU = [];
{if ((side _x) == west) then {f_param_vehicles_BLU = f_param_vehicles_BLU + [_x]}} forEach f_param_vehicles;

// DEBUG
if (f_param_debugMode == 1) then
{
	_str_f_param_vehicles_BLU = str f_param_vehicles_BLU;
	DEBUG_OUTPUT format ["DEBUG %2: f_param_vehicles_BLU = %1",_str_f_param_vehicles_BLU, SLV_NAME];
};

// ====================================================================================

// COMMON VARIABLE: f_param_vehicles_RES
// Using f_param_vehicles we will create an array containing all resistance vehicles.

f_param_vehicles_RES = [];
{if ((side _x) == resistance) then {f_param_vehicles_RES = f_param_vehicles_RES + [_x]}} forEach f_param_vehicles;

// DEBUG
if (f_param_debugMode == 1) then
{
	_str_f_param_vehicles_RES = str f_param_vehicles_RES;
	DEBUG_OUTPUT format ["DEBUG %2: f_param_vehicles_RES = %1",_str_f_param_vehicles_RES, SLV_NAME];
};

// ====================================================================================

// COMMON VARIABLE: f_param_vehicles_OPF
// Using f_param_vehicles we will create an array containing all OPFOR vehicles.

f_param_vehicles_OPF = [];
{if ((side _x) == east) then {f_param_vehicles_OPF = f_param_vehicles_OPF + [_x]}} forEach f_param_vehicles;

// DEBUG
if (f_param_debugMode == 1) then
{
	_str_f_param_vehicles_OPF = str f_param_vehicles_OPF;
	DEBUG_OUTPUT format ["DEBUG %2: f_param_vehicles_OPF = %1",_str_f_param_vehicles_OPF, SLV_NAME];
};

// ====================================================================================

// COMMON VARIABLE: f_param_vehicles_CIV
// Using f_param_vehicles we will create an array containing all civilian vehicles.

f_param_vehicles_CIV = [];
{if ((side _x) == civilian) then {f_param_vehicles_CIV = f_param_vehicles_CIV + [_x]}} forEach f_param_vehicles;

// DEBUG
if (f_param_debugMode == 1) then
{
	_str_f_param_vehicles_CIV = str f_param_vehicles_CIV;
	DEBUG_OUTPUT format ["DEBUG %2: f_param_vehicles_CIV = %1",_str_f_param_vehicles_CIV, SLV_NAME];
};

