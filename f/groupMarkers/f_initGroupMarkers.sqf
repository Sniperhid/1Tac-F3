
if (!hasInterface) exitWith {}; // Only needed on clients

// ====================================================================================

// MAKE SURE THE PLAYER INITIALIZES PROPERLY

if (!isDedicated && (isNull player)) then
{
    waitUntil {sleep 0.1; !isNull player};
};

// ====================================================================================

// DETECT PLAYER FACTION
// The following code detects what faction the player's slot belongs to, and stores
// it in the private variable _unitfaction
params[["_unitfaction",(toLower (faction (leader group player)))]];

// ====================================================================================
// Init: check if optional pbo is loaded
f_groupMarkers_pboLoaded = false;

if (isClass(configFile >> "CfgPatches" >> "f3_groupmarkers")) then {
	f_groupMarkers_pboLoaded = true;
};

f_grpMkr_groups = [];
f_grpMkr_delay = 3;

// Briefing
if (isMultiplayer) then {
    [] spawn {
        uiSleep 2;
        if(isServer) then {
            waitUntil {!isNull (findDisplay 52)};
             ((findDisplay 52) displayctrl 51) ctrlAddEventHandler ["draw",{_this call F_fnc_drawGroupMarkers}];
        } else {
            waitUntil {!isNull (findDisplay 53)};
             ((findDisplay 53) displayctrl 51) ctrlAddEventHandler ["draw",{_this call F_fnc_drawGroupMarkers}];
        };
    };
};


// Ingame Map
[{
    if (isNull findDisplay 12) exitWith {};
    
    ((findDisplay 12) displayctrl 51) ctrlAddEventHandler ["draw",{_this call F_fnc_drawGroupMarkers}];
    [_this select 1] call CBA_fnc_removePerFrameHandler;
}, 0] call CBA_fnc_addPerFrameHandler;

//GPS
[{
    if (isNull (uiNamespace getVariable "RscMiniMap")) exitWith {};
    
    if ((((uiNamespace getVariable "RscMiniMap") displayctrl 101) ctrlAddEventHandler ["draw",{_this call F_fnc_drawGroupMarkers}]) > 0) then {
        [_this select 1] call CBA_fnc_removePerFrameHandler;
    };
}, 1] call CBA_fnc_addPerFrameHandler;


// Displays that are not created using createDialog, are not easily trackable such as tao's folding map.

//Tao Folding map support.
if (isClass(configFile >> "CfgPatches" >> "tao_foldmap_a3")) then {
    [] spawn {
		private "_control1";
		disableSerialization;
        while {true} do {
            waitUntil {sleep 1;!isNull (uiNamespace getVariable "tao_foldmap")};
            _control1 = ((uiNamespace getVariable "tao_foldmap") displayctrl 40);
            ((uiNamespace getVariable "tao_foldmap") displayctrl 40) ctrlAddEventHandler ["draw",{_this call F_fnc_drawGroupMarkers}];
            ((uiNamespace getVariable "tao_foldmap") displayctrl 41) ctrlAddEventHandler ["draw",{_this call F_fnc_drawGroupMarkers}];
            waitUntil{sleep 1;isNull _control1};
        };
    };
};

//ACE3 Micro Dagr
if (isClass(configFile >> "CfgPatches" >> "ace_microdagr")) then {
    
    [{
        disableSerialization;
        params["_args"];
        _args params ["_gm_ace_md_display","_gm_ace_md_dialog"];
       
        if (isNull _gm_ace_md_display) then {
            if (!isNull (uiNamespace getVariable "ace_microdagr_rsctitledisplay")) then {
                _gm_ace_md_display = ((uiNamespace getVariable "ace_microdagr_rsctitledisplay") displayctrl 77702);
                _gm_ace_md_display ctrlAddEventHandler ["draw",{_this call F_fnc_drawGroupMarkers}];
                _args set [0,_gm_ace_md_display];
            };
        };
        
        if (isNull _gm_ace_md_dialog) then {
            if (!isNull (uiNamespace getVariable "ace_microdagr_dialogdisplay")) then {
                _gm_ace_md_dialog = ((uiNamespace getVariable "ace_microdagr_dialogdisplay") displayctrl 77702);
                _gm_ace_md_dialog ctrlAddEventHandler ["draw",{_this call F_fnc_drawGroupMarkers}];
                _args set [1,_gm_ace_md_dialog];
            };
        };
        
    }, 1,[controlNull,controlNull]] call CBA_fnc_addPerFrameHandler;

};


// ====================================================================================
// Actively monitor reported displays, such that all BIS displays function properly.

[_unitfaction,true] call f_fnc_setupGroupMarkers;

//Spawn thread to update fireteam positions overtime.

f_groupMarkersPFHUpdate = {
    private["_color","_fireTeamMarkers"];
    f_grpMkr_groups call f_fnc_updateGroupMarkers;
    _fireTeamMarkers = [];
    {
        if (!isNull _x) then {
            _color = [1,1,1,0.85];
            switch (assignedTeam _x) do {
              case "RED": {_color = [1,0,0,0.85]};
              case "GREEN": {_color = [0,1,0,0.85]};
              case "BLUE": {_color = [0,0,1,0.85]};
              case "YELLOW": {_color = [1,1,0,0.85]};
            };
            _fireTeamMarkers pushBack [(getPos _x),(getDir _x),_color];
        };
    } forEach (units (group player));
    f_ftMkr_data = _fireTeamMarkers; // atomic :) 
};


[] spawn {
    [] call f_groupMarkersPFHUpdate;
    sleep f_grpMkr_delay;
    [f_groupMarkersPFHUpdate, f_grpMkr_delay, []] call CBA_fnc_addPerFrameHandler;
};
