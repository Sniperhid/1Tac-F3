// F3 - Radio Framework initialisation
// Credits: Please see the F3 online manual (http://www.ferstaberinde.com/f3/en/)
// ====================================================================================

// RUN RELEVANT SCRIPTS, DEPENDING ON SYSTEM IN USE
// Each radio modification requires a different set of scripts to be used, and so we
// split into a seperate script file for initialisation of each mod, on both the
// server and client.

// If any radio system selected
if (isClass(configFile >> "CfgPatches" >> "acre_main")) then {
    [] execVM "f\radios\acre2\acre2_init.sqf";
};


// ====================================================================================
