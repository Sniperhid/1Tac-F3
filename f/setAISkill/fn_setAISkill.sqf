// F3 - SetAISkill
// Credits: Please see the F3 online manual (http://www.ferstaberinde.com/f3/en/)
// ====================================================================================
// DECLARE VARIABLES SET KEY VARIABLES

private ["_skill","_skillarray"];
params["_unit",["_skillset",false]];

_skill = 99;
_skillarray = _skillset; // If _skillset is not an array of skills, _skillarray will be properly set further down

// ====================================================================================
// FAULT CHECK
// If f_setAISkill.sqf has not been run exit with an error message

if ((isNil "f_param_skillSet") || (isNil "f_param_skillRandom")) exitWith {systemchat "F3 SetAISkill DBG: f_setAISkill.sqf needs to run before calling f_fnc_setAISkill!"};

// ====================================================================================
// If the unit was already processed, exit the function
if (_unit getVariable ["f_setAISkill",false]) exitWith {};

// ====================================================================================
// If no skill-array was passed, set it to the relevant side's skill-level at first
if (_skillset isEqualType false) then {
	_skillset =
	switch (side _unit) do {
			case west: {f_param_skillBLU};
			case blufor: {f_param_skillBLU};
			case east: {f_param_skillOPF};
			case opfor: {f_param_skillOPF};
			case independent: {f_param_skillRES};
			case resistance: {f_param_skillRES};
			case civilian: {f_param_skillCIV};
			default {0};
	};
};

// ====================================================================================
// If the faction's skill level is not configured, exit and ignore the unit from now on
if (_skillset isEqualType 0 && {_skillset == 99}) exitWith {_unit setVariable ["f_setAISkill",true];};

// ====================================================================================
// If a specific skill level was passed, populate _skillArray using the new value.
if (_skillset isEqualType 0) then {
	_skill = _skillset;
	_skillArray = [];
	for '_x' from 0 to 8 do {
		_skilllevel = (f_param_skillSet select _x) * _skill;
		_skillArray pushBack (_skilllevel + random f_param_skillRandom - random f_param_skillRandom);
	};
};

// ====================================================================================
// We loop through all skilltypes and set them for the individual unit
{
	_unit setSkill [_x,_skillarray select _forEachIndex];
} forEach ['aimingAccuracy','aimingShake','aimingSpeed','spotDistance','spotTime','courage','reloadSpeed','commanding','general'];

// Mark the unit as processed
_unit setVariable ["f_setAISkill",true];

// Return true
true