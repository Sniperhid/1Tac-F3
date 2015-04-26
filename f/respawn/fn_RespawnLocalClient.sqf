_groupNum = _this select 0;
_position = _this select 1;
_faction = _this select 2; // facton id number.
_typeOfUnit = _this select 3;
_rank = _this select 4;
_number = _this select 5;
_leader = _this select 6;
_halo = _this select 7;

_faction = (respawnMenuFactions select _faction) select 0;
_class = [_faction,_typeOfUnit] call fn_respawnSelectClass;

_sideNum = getNumber (configfile >> "CfgFactionClasses" >> _faction >> "side");
_side = switch (_sideNum) do {
    case 0: {east};
    case 1: {west};
    case 2: {resistance};
    case 3: {civilian};
    default {civilian};
};

_rankName  = switch (_rank) do {
    case 0: {"PRIVATE"};
    case 1: {"CORPORAL"};
    case 2: {"SERGEANT"};
    case 3: {"LIEUTENANT"};
    case 4: {"CAPTAIN"};
    case 5: {"MAJOR"};
    case 6: {"COLONEL"};
    default {"PRIVATE"};
};

if (_halo) then {
  _position set[2,550];
  ["HALO"] call BIS_fnc_startLoadingScreen;
};

//Dummy group is required to
_dummyGroup = createGroup _side;
respawn_initComplete = false;
/// Create the unit
_unitName = format["respawnedUnit%1",_number];
_init = format[" %1 = this; ['%2',this] call f_fnc_assignGear; if (local this) then { respawn_initComplete = true; }; this setName '%1';",_unitName, (respawnMenuRoles select _typeOfUnit) select 0, name player];
_oldUnit = player;
_class createUnit [_position,_dummyGroup,_init,0.5,_rankName];	

// Wait till the unit is created
waitUntil{!isNil _unitName};

call compile format ["localRespawnedUnit = %1 ",_unitName];

// Exit Spectator
[] call F_fnc_ForceExit;
// Ensures the spectator script will create a virtual entity next time.
f_cam_VirtualCreated = nil; 

_name = (name player);
//addSwitchableUnit localRespawnedUnit; This will create awkard mission ends.
setPlayable localRespawnedUnit;
selectPlayer localRespawnedUnit;
//localRespawnedUnit setName _name;

deleteVehicle _oldUnit; // Delete the old spectator module
localRespawnedUnit = nil; // Enable respawn again.
player setPos (_position);

if (_halo) then {
  [_position] spawn {
        hint "HALO INSERTATION";
        waitUntil{respawn_initComplete};
        player setPos (_this select 0);
        //Loadout?
        removeBackpack player;
        player addBackpack "B_parachute";
        ["HALO"] call BIS_fnc_endLoadingScreen;

        _jumper = player;
      
        while {(getPos _jumper select 2) > 2} do {
            if (getPos _jumper select 2 < 150) then {
                _jumper action ["OpenParachute", _jumper];
            };
            if(!alive _jumper) then {
                _jumper setPos [getPos _jumper select 0, getPos _jumper select 1, 0];
            };
        };
      
        //	Fix backpack?
      
      
  };
    
};

// Spawn to avoid blocking with waitUntil for assignGear to finish.
[] spawn {
    switch (f_param_radios) do {
      case 1: {
        [false] call acre_api_fnc_setSpectator;
        [] call f_acre2_clientInit;
      };
    };
};

 _groupVarName = format ["GrpRespawn_%1",_groupNum];
if (_leader) then {
    //Broadcast group var to everyone so people can join.
    call compile format["%1 = _dummyGroup;",_groupVarName];
    publicVariable _groupVarName;
    
} else {
    //Wait for group be created by the group leader before joining it.
    [_groupVarName] spawn {
        _groupVarName = _this select 0;
        // Wait for group exist.
        sleep 1; // Ensure that everything is in Sync.
        waitUntil{!isNil _groupVarName};
        call compile format["[player] joinSilent %1;",_groupVarName];
   };
};

// Re-initalize our group markers
[_faction,true] call f_fnc_setupGroupMarkers;

// Add all the respawned groups to the map markers as well.
[] call F_fnc_RespawnGroupMarkerUpdate;

[] execVM "f\medical\medical_init.sqf";



// Re-run briefing script for our new unit.
f_script_briefing = [] execVM "briefing.sqf";
[] execVM "f\briefing\f_orbatNotes.sqf";
[] execVM "f\briefing\f_loadoutNotes.sqf";