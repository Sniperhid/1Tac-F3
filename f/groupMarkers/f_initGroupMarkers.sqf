private ["_unitfaction","_style"];

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
_unitfaction = "";
if(count _this == 0) then
{
	_unitfaction = toLower (faction player);

	// If the unitfaction is different from the 	group leader's faction, the leader's faction is used
	if (_unitfaction != toLower (faction (leader group player))) then {_unitfaction = toLower (faction (leader group player))};
}
else
{
	_unitfaction = (_this select 0);
};

// ====================================================================================
// Init: check if optional pbo is loaded
f_groupMarkers_pboLoaded = false;

if (isClass(configFile >> "CfgPatches" >> "f3_groupmarkers")) then {
	f_groupMarkers_pboLoaded = true;
};

f_grpMkr_groups = [];
f_grpMkr_delay = 3;


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

[] spawn {
	sleep 1; // won't be null till game start, might as well stop waiting during the briefing.
	waitUntil {!isNull (findDisplay 12)};
	((findDisplay 12) displayctrl 51) ctrlAddEventHandler ["draw",{_this call F_fnc_drawGroupMarkers}];
	waitUntil {sleep 1;!isNull (uiNamespace getVariable "RscMiniMap")};
	((uiNamespace getVariable "RscMiniMap") displayctrl 101) ctrlAddEventHandler ["draw",{_this call F_fnc_drawGroupMarkers}];
};

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
	[] spawn {
		private "_control1";
		disableSerialization;
		while {true} do {
			waitUntil {sleep 1;!isNull (uiNamespace getVariable "ace_microdagr_dialogdisplay")};
			_control1 = ((uiNamespace getVariable "ace_microdagr_dialogdisplay") displayctrl 77702);
			_control1 ctrlAddEventHandler ["draw",{_this call F_fnc_drawGroupMarkers}];
			waitUntil{sleep 1;isNull _control1};
		};
	};
	[] spawn {
		private "_control1";
		disableSerialization;
		while {true} do {
			waitUntil {sleep 1;!isNull (uiNamespace getVariable "ace_microdagr_rsctitledisplay")};
			_control1 = ((uiNamespace getVariable "ace_microdagr_rsctitledisplay") displayctrl 77702);
			_control1 ctrlAddEventHandler ["draw",{_this call F_fnc_drawGroupMarkers}];
			waitUntil{sleep 1;isNull _control1};
		};
	};
};


// ====================================================================================
// Actively monitor reported displays, such that all BIS displays function properly.
/*
[] spawn {
    f_groupMarkersActiveMapControls = [];
    while {true} do
    {
        disableSerialization;
        {
            _display = _x;
            {
                if (ctrlMapScale _x != 0) then {
                    if !(_x in f_groupMarkersActiveMapControls ) then { 
                        f_groupMarkersActiveMapControls pushBack _x;
                        _x ctrlAddEventHandler ["draw",{_this call F_fnc_drawGroupMarkers}];
                    };
                };
            } forEach allControls _display;
        } forEach allDisplays;
        
        {
            _display = _x;
            {
                if (ctrlMapScale _x != 0) then {
                    if !(_x in f_groupMarkersActiveMapControls ) then {
                        f_groupMarkersActiveMapControls pushBack _x;
                        _x ctrlAddEventHandler ["draw",{_this call F_fnc_drawGroupMarkers}];
                    };
                };
            } forEach allControls _display;
        } forEach (uiNameSpace getVariable "igui_displays");
        sleep 1;
        //Garbage collect old controls.
        f_groupMarkersActiveMapControls = f_groupMarkersActiveMapControls - [controlNull];
    };
};
*/

[_unitfaction,true] call f_fnc_setupGroupMarkers;

//Spawn thread to update fireteam positions overtime.
[] spawn {
    uiSleep 1;
    private["_color","_dir","_pos","_fireTeamMarkers"];
    while {true} do {
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
                _dir = getDir _x;
                _pos = getPos _x;
                _fireTeamMarkers pushBack [_pos,_dir,_color];
            };
        } forEach (units (group player));
        f_ftMkr_data = _fireTeamMarkers; // atomic :)
        sleep f_grpMkr_delay;    
    };
};
