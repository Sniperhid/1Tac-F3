private["_in","_meanPos","_retPos","_rootNode","_maxDist","_maxDistPos","_minDistPos","_thisIdx","_minChildDist","_minDistPos","_dist","_xObject","_childPos","_ret","_i","_retMaxDistPos"];

//Update the positions and the closest/furthest away position caches recursively. Run the update in the scheluded enviornment to lower overhead.

_meanPos = [0,0,0];
_retPos = [];

_in = _this;
_rootNode = (_in select 0);

//Old mean = _rootNode select 4;
_maxDist = 0;
_maxDistPos = _rootNode select 4;
if (count _in > 1) then {
    for "_i" from 1 to (count _in - 1) do {
		_xObject = (_in select _i);
		_ret = _xObject call f_fnc_updateGroupMarkers;
		_retPos = _ret select 0;
		_retMaxDistPos = _ret select 1;
		_meanPos = _meanPos vectorAdd _retPos;
		_thisIdx = _i;
		_minChildDist = 100000;
		_minDistPos = [0,0,0];
		_dist = (_retPos distanceSqr (_rootNode select 4)); // old mean.
		if (_dist > _maxDist) then {
			_maxDist = _dist;
			_maxDistPos = ((_xObject select 0) select 4);
		};
		_dist = (_retMaxDistPos distanceSqr (_rootNode select 4)); // old mean.
		if (_dist > _maxDist) then {
			_maxDist = _dist;
			_maxDistPos = _retMaxDistPos;
		};
        for "_i" from 1 to (count _in - 1) do {
			if ((_thisIdx != _i)) then {
				_childPos = (((_in select _i) select 0) select 4);
				_dist = (_retPos distanceSqr _childPos);
				if (_dist < _minChildDist) then {
					_minChildDist = _dist;
					_minDistPos = _childPos;
				};
			};
		};
        (_xObject select 0) set[5,_minDistPos]; 
    };
    _rootNode set[6,_maxDistPos];
    _meanPos = _meanPos vectorMultiply (1 / ((count _in) -1)); // -1 as first one is the root node. (Get the true mean)
    _rootNode set[4,_meanPos];
    _retPos = _meanPos;        
} else {
    private["_thing","_pos"];
    _thing = _rootNode select ((count _rootNode) -1);
    _pos = [0,0,0];
    if(_thing isEqualType grpNull) then {_pos = getPos leader _thing};
    if(_thing isEqualType objNull) then {_pos = getPos _thing};
    if !(_pos isEqualTo [0,0,0]) then {
        _rootNode set[4,_pos];
        _retPos = _pos;
    } else {
        _retPos = _rootNode select 4;
    };
};
[_retPos,_maxDistPos]