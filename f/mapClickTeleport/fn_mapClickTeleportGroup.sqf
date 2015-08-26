// F3 - Mission Maker Teleport
// Credits: Please see the F3 online manual (http://www.ferstaberinde.com/f3/en/)
// ====================================================================================
// DECLARE VARIABLES AND FUNCTIONS AND SET KEY VARIABLES
private ["_units","_textDone","_dispersion"];
params["_unit","_pos"];

_dispersion = 100; // The maximum dispersion for units when HALO jumping

f_param_mapClickTeleport_textDone = "You have been moved to the selected location.";

// ====================================================================================
// LOCALITY CHECK
// The component should not run anywhere else but where the unit is local by default
// This check is a redundancy to ensure this

if !(local _unit) exitWith {};

// ====================================================================================
// TELEPORT UNITS
// Loop through the group's units (excluding the leader) and check if they are local, if true teleport
// them next to the leader and display a notification for players

if (f_param_mapClickTeleport_Height == 0) then {
	_unit setPos [((_pos select 0) + 3 + random 3),((_pos select 1) + 3 + random 3),(_pos select 2)];
} else {
	_unit setPos [((_pos select 0) + random _dispersion - random _dispersion),((_pos select 1) + random _dispersion - random _dispersion),(_pos select 2) + random 15 - random 15];
};

// Display a notification for players
if (_unit == vehicle player) then {["MapClickTeleport",[f_param_mapClickTeleport_textDone]] call BIS_fnc_showNotification};

// HALO - BACKPACK
// If unit is parajumping, spawn the following code to add a parachute and restore the old backpack after landing

if (f_param_mapClickTeleport_Height > 0) then {
	[_unit] spawn {
		private ["_bp","_bpi"];
        params["_unit"];
		_bp = backpack _unit;
		_bpi = backpackItems _unit;

		removeBackpack _unit;
		_unit addBackpack "B_parachute";
		waitUntil {sleep 0.1;isTouchingGround _unit;};
		if (alive _unit) then {
			removeBackpack _unit;
			_unit addBackpack _bp;
			{
			   (unitBackpack _unit) addItemCargoGlobal [_x,1];
			} forEach _bpi;
		};
	};
};
