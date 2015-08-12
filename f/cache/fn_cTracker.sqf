// F3 - Caching Script Tracker
// Credits: Please see the F3 online manual (http://www.ferstaberinde.com/f3/en/)
// ====================================================================================

// DECLARE VARIABLES AND FUNCTIONS
private "_debug";
params["_range"];

_debug = if (f_param_debugMode == 1) then [{true},{false}];

// ====================================================================================
// BEGIN THE TRACKING LOOP
while {f_param_cacheRun} do {
    if (_debug) then{player globalchat format ["f_fnc_cache DBG: Tracking %1 groups",count allGroups]};
    {
        if !(isNull _x) then {
            _exclude = _x getVariable ["f_cacheExcl",false];
            _cached = _x getVariable ["f_cached", false];

            if (!_exclude) then {
                if (_cached) then {

                    if (_debug) then {player globalchat format ["f_fnc_cache DBG: Checking group: %1",_x]};

                    if ([leader _x, _range] call f_fnc_nearPlayer) then {

                        if (_debug) then {player globalChat format ["f_fnc_cache DBG: Decaching: %1",_x]};

                        _x setVariable ["f_cached", false];
                        _x spawn f_fnc_gUncache;

                    };
                } else {
                    if !([leader _x, _range * 1.1] call f_fnc_nearPlayer) then {

                        if (_debug) then {player globalChat format ["f_fnc_cache DBG: Caching: %1",_x]};

                        _x setVariable ["f_cached", true];
                        [_x] spawn f_fnc_gCache;
                    };
                };

                //if (_debug) then {player globalChat format ["f_fnc_cache DBG: Group is excluded: %1",_x]};
            };
        };
    } forEach allGroups;

    sleep f_param_cacheSleep;
};

// If the caching loop is terminated, uncache all cached groups
{
    if (_x getVariable ["f_cached", false]) then {
        _x spawn f_fnc_gUncache;
        _x setVariable ["f_cached", false];
    };
} forEach allGroups;