// F3 - F3 Common Local Variables
// Credits: Please see the F3 online manual (http://www.ferstaberinde.com/f3/en/)
// ====================================================================================

// ====================================================================================
// COMMON VARIABLE: f_param_units
// We will create an array containing all units.

f_param_units = allUnits + vehicles;

// ====================================================================================
// COMMON VARIABLE: f_param_units_BLU
// Using f_param_units we will create an array containing all BLUFOR units.

f_param_units_BLU = [];
{if ((side _x) == west ) then {f_param_units_BLU = f_param_units_BLU + [_x]}} forEach f_param_units;

// ====================================================================================
// COMMON VARIABLE: f_param_units_RES
// Using f_param_units we will create an array containing all resistance units.

f_param_units_RES = [];
{if ((side _x) == resistance) then {f_param_units_RES = f_param_units_RES + [_x]}} forEach f_param_units;


// ====================================================================================
// COMMON VARIABLE: f_param_units_OPF
// Using f_param_units we will create an array containing all OPFOR units.

f_param_units_OPF = [];
{if ((side _x) == east) then {f_param_units_OPF = f_param_units_OPF + [_x]}} forEach f_param_units;

// ====================================================================================
// COMMON VARIABLE: f_param_units_CIV
// Using f_param_units we will create an array containing all civilian units.

f_param_units_CIV = [];
{if ((side _x) == civilian) then {f_param_units_CIV = f_param_units_CIV + [_x]}} forEach f_param_units;

// ====================================================================================
// COMMON VARIABLE: f_param_men
// Using the master trigger we will create an array containing all men.

f_param_men = [];
{
	if ((_x isKindOf "CAManBase")) then
	{
		f_param_men pushBack _x;
	};
} forEach f_param_units;

// ====================================================================================
// COMMON VARIABLE: f_param_men_BLU
// Using f_param_men we will create an array containing all BLUFOR men.

f_param_men_BLU = [];
{if ((side _x) == west) then {f_param_men_BLU pushBack _x;}} forEach f_param_men;

// ====================================================================================
// COMMON VARIABLE: f_param_men_RES
// Using f_param_men we will create an array containing all resistance men.

f_param_men_RES = [];
{if ((side _x) == resistance) then {f_param_men_RES pushBack _x;}} forEach f_param_men;

// ====================================================================================
// COMMON VARIABLE: f_param_men_OPF
// Using f_param_men we will create an array containing all OPFOR men.

f_param_men_OPF = [];
{if ((side _x) == east) then {f_param_men_OPF pushBack _x;}} forEach f_param_men;

// ====================================================================================
// COMMON VARIABLE: f_param_men_CIV
// Using f_param_men we will create an array containing all civilian men.

f_param_men_CIV = [];
{if ((side _x) == civilian) then {f_param_men_CIV pushBack _x;}} forEach f_param_men;

// ====================================================================================
// COMMON VARIABLE: f_param_men_players
// Using f_param_men we will create an array containing all players.

f_param_men_players = [];
{if (isPlayer _x) then {f_param_men_players pushBack _x;}} forEach f_param_men;

// ====================================================================================
// COMMON VARIABLE: f_param_groups_BLU
// Using f_param_units_BLU we will create an array containing all BLUFOR groups.

f_param_groups_BLU = [];
{if (!((group _x) in f_param_groups_BLU)) then {f_param_groups_BLU pushBack (group _x);}} forEach f_param_units_BLU;

// ====================================================================================
// COMMON VARIABLE: f_param_groups_RES
// Using f_param_units_RES we will create an array containing all resistance groups.

f_param_groups_RES = [];
{if (!((group _x) in f_param_groups_RES)) then {f_param_groups_RES pushBack (group _x);}} forEach f_param_units_RES;

// ====================================================================================
// COMMON VARIABLE: f_param_groups_OPF
// Using f_param_units_OPF we will create an array containing all OPFOR groups.

f_param_groups_OPF = [];
{if (!((group _x) in f_param_groups_OPF)) then {f_param_groups_OPF pushBack (group _x);}} forEach f_param_units_OPF;

// ====================================================================================
// COMMON VARIABLE: f_param_groups_CIV
// Using f_param_units_CIV we will create an array containing all civilian groups.

f_param_groups_CIV = [];
{if (!((group _x) in f_param_groups_CIV)) then {f_param_groups_CIV pushBack (group _x);}} forEach f_param_units_CIV;

// ====================================================================================
// COMMON VARIABLE: f_param_groups
// We will create an array containing all groups.

f_param_groups = allGroups;

// ====================================================================================
// COMMON VARIABLE: f_param_groups_players
// We will create an array containing all groups with at least one player.

f_param_groups_players = [];
{
	_units = units _x;
	if ({isPlayer _x} count _units >= 1) then {
		f_param_groups_players pushBack _x;
	};
} forEach f_param_groups;

// ====================================================================================
// COMMON VARIABLE: f_param_vehicles
// We will create an array containing all vehicles.

f_param_vehicles = vehicles;

// ====================================================================================
// COMMON VARIABLE: f_param_vehicles_BLU
// Using f_param_vehicles we will create an array containing all BLUFOR vehicles.

f_param_vehicles_BLU = [];
{if ((side _x) == west) then {f_param_vehicles_BLU pushBack _x;}} forEach f_param_vehicles;

// ====================================================================================
// COMMON VARIABLE: f_param_vehicles_RES
// Using f_param_vehicles we will create an array containing all resistance vehicles.

f_param_vehicles_RES = [];
{if ((side _x) == resistance) then {f_param_vehicles_RES pushBack _x;}} forEach f_param_vehicles;

// ====================================================================================
// COMMON VARIABLE: f_param_vehicles_OPF
// Using f_param_vehicles we will create an array containing all OPFOR vehicles.

f_param_vehicles_OPF = [];
{if ((side _x) == east) then {f_param_vehicles_OPF pushBack _x;}} forEach f_param_vehicles;

// ====================================================================================
// COMMON VARIABLE: f_param_vehicles_CIV
// Using f_param_vehicles we will create an array containing all civilian vehicles.

f_param_vehicles_CIV = [];
{if ((side _x) == civilian) then {f_param_vehicles_CIV pushBack _x;}} forEach f_param_vehicles;


