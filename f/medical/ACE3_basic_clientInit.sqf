// F3 - AGM Clientside Initialisation
// Credits: Please see the F3 online manual (http://www.ferstaberinde.com/f3/en/)
// ====================================================================================

// Wait for gear assignation to take place
waitUntil{(player getVariable ["f_var_assignGear_done", false])};

private "_typeOfUnit";

_typeOfUnit = player getVariable "f_var_assignGear";

// Remove pre-assigned medical items
{player removeItems _x} forEach ["FirstAidKit","Medikit","ACE_fieldDressing","ACE_packingBandage","ACE_elasticBandage","ACE_tourniquet","ACE_morphine","ACE_atropine","ACE_epinephrine","ACE_plasmaIV","ACE_plasmaIV_500","ACE_plasmaIV_250","ACE_bloodIV","ACE_bloodIV_500","ACE_bloodIV_250","ACE_salineIV","ACE_salineIV_500","ACE_salineIV_250","ACE_quikclot","ACE_personalAidKit","ACE_surgicalKit","ACE_bodyBag"];

// Add basic items to all units
if (isClass(configFile >> "CfgPatches" >> "ace_hearing")) then {
    //player addItem "ACE_EarPlugs";
    player setVariable ["ACE_hasEarPlugsIn", true, true];
};

{player addItem "ACE_fieldDressing"} forEach [1,2,3,4];
player addItem "ACE_tourniquet";
player addItem "ACE_morphine";

if (_typeOfUnit == "m") then
{
    player addItem "ACE_tourniquet"; // extra tourniquet
	// BACKPACK: LIGHT
	if (f_param_backpacks <= 1) then {
		(unitBackpack player) addItemCargoGlobal ["ACE_fieldDressing",  15];
		(unitBackpack player) addItemCargoGlobal ["ACE_morphine", 10];
		(unitBackpack player) addItemCargoGlobal ["ACE_epinephrine",   10];
		(unitBackpack player) addItemCargoGlobal ["ACE_bloodIV", 2];
        (unitBackpack player) addItemCargoGlobal ["ACE_tourniquet",  2];
	};
	// BACKPACK: HEAVY
	if (f_param_backpacks == 2) then {
		(unitBackpack player) addItemCargoGlobal ["ACE_fieldDressing", 25];
		(unitBackpack player) addItemCargoGlobal ["ACE_morphine", 15];
		(unitBackpack player) addItemCargoGlobal ["ACE_epinephrine",   15];
		(unitBackpack player) addItemCargoGlobal ["ACE_bloodIV", 4];
        (unitBackpack player) addItemCargoGlobal ["ACE_tourniquet",  3];
	};
};


if (isClass(configFile >> "CfgPatches" >> "ace_maptools")) then {
    if (_typeOfUnit in ["co", "dc", "m", "mmgag", "hmgag", "matag", "hatag", "mtrag", "mtrg","msamag","sp","vc", "pp", "uav"]) then {
        player addItem "ACE_Maptools";
    };
};

if (isClass(configFile >> "CfgPatches" >> "ace_kestrel")) then {
    if (_typeOfUnit in ["sn","sp"]) then {
        player addItem "ACE_Kestrel";
    };    
};

if (isClass(configFile >> "CfgPatches" >> "ace_microdagr")) then {
    if (_typeOfUnit in ["co","dc","sp"]) then {
        player addItem "ACE_microDAGR";
    };  
};

if (isClass(configFile >> "CfgPatches" >> "ace_explosives")) then {
    if (_typeOfUnit in ["eng","engm"]) then {
        player addItem "ACE_M26_Clacker";
        player addItem "ACE_DefusalKit";
    };  
};

if (isClass(configFile >> "CfgPatches" >> "ace_logistics_wirecutter")) then {
    if (_typeOfUnit in ["eng","engm"]) then {
        player addItem "ACE_wirecutter";
    };  
};

// Put weapon safety on.
sleep 0.01;
if (currentWeapon player != "") then {
    [player, currentWeapon player, currentMuzzle player] call ACE_safemode_fnc_lockSafety;
};