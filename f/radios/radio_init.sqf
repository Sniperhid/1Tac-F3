
// If ACRE2 loaded use ACRE2.
if (isClass(configFile >> "CfgPatches" >> "acre_main")) then {
    #define isUnitInGroupArray f_addon_fnc_isUnitInGroupArray
    #define isUnitLeaderInGroupArray f_addon_fnc_isUnitLeaderInGroupArray
    
	#include "acre2_settings.sqf"
    [] spawn f_addon_fnc_acre2_init;
};
