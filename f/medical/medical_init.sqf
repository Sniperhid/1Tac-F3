// F3 - Medical Systems Support initialisation
// Credits: Please see the F3 online manual (http://www.ferstaberinde.com/f3/en/)
// ====================================================================================

// RUN RELEVANT SCRIPTS, DEPENDING ON SYSTEM IN USE
// Each medical modification requires a different set of scripts to be used, and so we
// split into a separate script file for initialisation of each mod.

// Wait for parameter to be initialised


if (hasInterface) then
{
    if (isClass(configFile >> "CfgPatches" >> "ace_medical")) then {
        [] execVM "f\medical\ACE3_basic_clientInit.sqf";
    };
};