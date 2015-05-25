private ["_unit","_faction","_typeOfUnit"];

_typeOfUnit = _this select 0;
_unit = _this select 1;

_faction = toLower (faction _unit);

if(count _this > 2) then { _faction = _this select 2; };

// ====================================================================================

// INSIGNIA
// This block will give units insignia on their uniforms.
[_unit,_typeofUnit] call f_fnc_assignInsignia;


if (!(local _unit)) exitWith {};
private ["_path","_uniforms","_vests","_headgears","_backpack","_primaryWeapons","_secondaryWeapons","_sidearmWeapons","_thingsNotAdded","_scopes","_bipods","_attachments","_silencers"];

_path = missionConfigFile >> "CfgLoadouts" >> _faction >> _typeOfUnit;

if(!isClass(_path)) exitWith {
    systemChat format ["[F3 Gear] No loadout called %1", _typeOfUnit]; 
    /*if (isNil "missingGearClasses") then { missingGearClasses = []; };
    if (_faction == "blu_f") then { missingGearClasses pushBack _typeOfUnit;};*/
};

_unit setVariable ["BIS_enableRandomization", false];

_unit setVariable ["f_var_assignGear",_typeofUnit,true];
_unit setVariable ["f_var_assignGear_done",false,true];

if (_unit isKindOf "CAManBase") then {
    _uniforms = getArray(_path >> "uniform");
    _vests = getArray(_path >> "vest");
    _headgears = getArray(_path >> "headgear");
    _backpack = getArray(_path >> "backpack");
    _goggles = getArray(_path >> "goggles");

    _primaryWeapons = getArray(_path >> "primaryWeapons");
    _secondaryWeapons = getArray(_path >> "secondaryWeapons");
    _sidearmWeapons = getArray(_path >> "sidearmWeapons");


    removeHeadgear _unit;
    removeUniform _unit;
    removeVest _unit;
    removeBackpack _unit;

    removeAllWeapons _unit;
    removeAllAssignedItems _unit;
    removeAllItemsWithMagazines _unit;



    // ====================================================================================
    // Clothes
    //#define selectRandom(array) array call BIS_fnc_selectRandom
    #define selectRandom(array) array select (floor (random (count array)))


    if (count _uniforms > 0) then { _unit forceAddUniform (selectRandom(_uniforms)); };
    if (count _vests > 0) then { _unit addVest (selectRandom(_vests)); };
    if (count _headgears > 0) then { _unit addHeadgear (selectRandom(_headgears)); };
    if (count _backpack > 0) then { _unit addBackpack (selectRandom(_backpack)); };
    if (count _goggles > 0) then { _unit addGoggles (selectRandom(_goggles)); };

    //clearAllItemsFromBackpack _unit;
    clearMagazineCargoGlobal (unitBackpack _unit);

    // ====================================================================================
    // Magazines
    _thingsNotAdded = [];
    {
        if (_unit canAdd _x) then {
           _unit addMagazine _x;
        } else {
            _thingsNotAdded pushBack _x;
        };
    } forEach (getArray(_path >> "magazines"));
    // ====================================================================================
    // Items
    {
        if (_unit canAdd _x) then {
            _unit addItem _x;
        } else {
            _thingsNotAdded pushBack _x;
        };
    } forEach (getArray(_path >> "items"));

    { _unit linkItem _x; } forEach getArray(_path >> "linkedItems");

    /////

    {
        if (_unit canAddItemToBackpack _x) then {
            _unit addItemToBackpack _x;
        } else {
            if (_unit canAdd _x) then {
                _unit addItem _x;
            } else {
                _thingsNotAdded pushBack _x; 
            };
        };
    } forEach (getArray(_path >> "backpackItems"));

    {
        if (_unit canAddItemToBackpack _x) then {
            (unitBackpack _unit) addMagazineCargoGlobal [_x,1];
        } else {
            if (_unit canAdd _x) then {
                _unit addItem _x;
            } else {
                _thingsNotAdded pushBack _x; 
            };
        };
    } forEach (getArray(_path >> "backpackMagazines"));



    // ====================================================================================
    // Weapons
    if (count _primaryWeapons > 0) then {_unit addWeapon (selectRandom(_primaryWeapons)); };
    if (count _secondaryWeapons > 0) then {_unit addWeapon (selectRandom(_secondaryWeapons)); };
    if (count _sidearmWeapons > 0) then {_unit addWeapon (selectRandom(_sidearmWeapons)); };

    // ====================================================================================
    // Attachments

    _scopes = getArray(_path >> "scopes");
    _bipods = getArray(_path >> "bipods");
    _attachments = getArray(_path >> "attachments");
    _silencers = getArray(_path >> "silencers");

    if (count _scopes > 0) then {_unit addPrimaryWeaponItem (selectRandom(_scopes)); };
    if (count _bipods > 0) then {_unit addPrimaryWeaponItem (selectRandom(_bipods)); };
    if (count _attachments > 0) then {_unit addPrimaryWeaponItem (selectRandom(_attachments)); };
    if (count _silencers > 0) then {_unit addPrimaryWeaponItem (selectRandom(_silencers)); };

    {_unit addSecondaryWeaponItem _x;} forEach getArray(_path >> "secondaryAttachments");
    {_unit addHandgunItem _x;} forEach getArray(_path >> "sidearmAttachments");


    //Try to add missing magazines:
    {
        if (!(_unit canAdd _x)) then {
            diag_log text format ["[F3 Gear] %1 (%3)- No room for equipment %2", _typeOfUnit, _x,_faction];
            systemChat format ["[F3 Gear] Failed To add equipment %1 to %2 (%3)", _x, _typeOfUnit,_faction];
        } else {
            systemChat format ["[F3 Gear][bug] Can re-add %1 to %2 (%3).", _x, _typeOfUnit,_faction];  
        };
    } forEach _thingsNotAdded;

    _unit setVariable ["f_var_assignGear_done",true,true];
    
} else { //Vehicles
    
    clearWeaponCargoGlobal _unit;
    clearMagazineCargoGlobal _unit;
    clearItemCargoGlobal _unit;
    clearBackpackCargoGlobal _unit;
    
    { _unit addMagazineCargoGlobal [_x, 1]; } forEach getArray(_path >> "cargoMagazines");
    { _unit addItemCargoGlobal [_x, 1]; } forEach getArray(_path >> "cargoItems");
    { _unit addWeaponCargoGlobal [_x, 1]; } forEach getArray(_path >> "cargoWeapons");
    { _unit addBackpackCargoGlobal [_x, 1]; } forEach getArray(_path >> "cargoBackpacks");
    
    
};