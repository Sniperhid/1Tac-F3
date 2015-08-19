
f_acre2_radios_calcFreq = {
	// INPUT 'RadioEntryEntry' <- from radioSettings
    // e.g. [0,1,1] call f_acre2_radios_calcFreq
	private["_radioSettingEntry","_randomSeed","_sizePresetBlock","_possibleSteps","_offset","_frequency"];

	params["_radioSettingIndexP","_presetNum","_chanNum"];

	_radioSettingEntry = f_radios_settings_acre2_radioSettings select _radioSettingIndexP;
	_radioSettingEntry params["_ignore","_minFreq","_maxFreq","_channelMinSpacing","_spacingBetweenChannels"];
	
	_randomSeed = 0;
	if (_presetNum == (count f_radios_settings_acre2_radioChannels)) then {
		_randomSeed = f_radios_settings_acre2_freqOffsets select ((count f_radios_settings_acre2_radioChannels)+ _chanNum - 1);
	} else {
		_randomSeed = (f_radios_settings_acre2_freqOffsets select _radioSettingIndexP);
	};

	_sizePresetBlock = (_spacingBetweenChannels / (count f_radios_settings_acre2_radioChannels + 1) ); // +1 is for special channels
	_possibleSteps = _sizePresetBlock / _channelMinSpacing; // if min spacing = 0.00625mhz, 0.25/0.00625= 40 (possible channels)
	 //  below:             'random side'  OFFSET      +  'frequency split' OFFSET.
	_offset = ((floor (_randomSeed*_possibleSteps))* _channelMinSpacing) + (_presetNum*_sizePresetBlock);

	_frequency = _minFreq + _offset + ((_chanNum-1) * _spacingBetweenChannels);
	_frequency
};

f_acre2_radioBaseNameToSettingsIdx = {
	private ["_fndIdx"];
	params["_radio"];

	_fndIdx = -1;
	{
		if (_radio in (_x select 0)) exitWith {
		  _fndIdx = _forEachIndex;
		};
	} forEach f_radios_settings_acre2_radioSettings;

	if (_fndIdx == -1) then { 
		systemChat format["Warning - F3 ACRE2 Assign - f_radios_settings_acre2_radioSettings missing radio: %1",_radio];
	};
	_fndIdx
};

{
	_radioPresetSetting = _x;
	_radioPresetSettingIndex = _forEachIndex;

	////// Bin Channels by Radio type.
	_channelsProcessed = []; // This will store channels, binned by radio type.
	{ _channelsProcessed pushBack []; } forEach f_radios_settings_acre2_radioSettings;

    for "_i" from 1 to (count _radioPresetSetting)-1 do {
        _channelEntry = _radioPresetSetting select _i;
        _radio = (_channelEntry select 2);
        (_channelsProcessed select ([_radio] call f_acre2_radioBaseNameToSettingsIdx)) pushBack _channelEntry + [false];  
    };

	///// Add Special Channels for consideration.
	{
		_specialRadioChannelEntry = _x;
		if (_radioPresetSettingIndex in (_specialRadioChannelEntry select 0)) then {
			_radio = (_specialRadioChannelEntry select 3);
			_dupEntry = + _specialRadioChannelEntry;
			_dupEntry deleteAt 0;
			//_dupEntry set [1,format["%1<font color='#d0c000'>*</font>",_dupEntry select 1]];
			(_channelsProcessed select ([_radio] call f_acre2_radioBaseNameToSettingsIdx)) pushBack _dupEntry + [true,(_forEachIndex+1)];  //Track index. 
			_radioPresetSetting pushBack _dupEntry;
		};
	} forEach (f_radios_settings_acre2_special_radioChannels);
	  
	////// Put these processed channels into presets.
	_presetName = format["f3preset%1",_radioPresetSettingIndex];
	_frequency = 0; // Create variable for use.
	_channelName = "";
	{
		//Create Preset.
		_radioSettingEntry = _x;
		_radioSettingIndex = _forEachIndex;
		_radioList = _radioSettingEntry select 0; // RadioList
		_channelList = (_channelsProcessed select _forEachIndex);
		// Create Presets....
		{
			_radioName = _x;

            [_radioName, (_radioSettingEntry select 5), _presetName] call acre_api_fnc_copyPreset; // tweak

			_channelCount = switch (_radioName) do {
				case "ACRE_PRC152": {100};
				case "ACRE_PRC148": {32};
				case "ACRE_PRC117F": {100};
				case "ACRE_PRC343": {80};
				default {0};
			};
			for "_i" from 1 to _channelCount do {
				_frequency = [_radioSettingIndex,_radioPresetSettingIndex,_i] call f_acre2_radios_calcFreq;
				if(_i > (count _channelList)) then { 
					_channelName = "Channel " + str(_i);
				} else {
					_channelEntry = _channelList select (_i-1);
					_channelName = (_channelEntry select 0);
					if (_channelEntry select 4) then { // Boolean to indiciate if is a special channel.
						_frequency = [_radioSettingIndex,(count f_radios_settings_acre2_radioChannels),(_channelEntry select 5)] call f_acre2_radios_calcFreq; // Use 'special preset' and 'special channel' number.
					};
				};
				
                [_radioName, _presetName, _i, "label", _channelName] call acre_api_fnc_setPresetChannelField;
				[_radioName, _presetName, _i, "frequencyTX", _frequency] call acre_api_fnc_setPresetChannelField;
				[_radioName, _presetName, _i, "frequencyRX", _frequency] call acre_api_fnc_setPresetChannelField;
			};
		} forEach _radioList;
	} forEach f_radios_settings_acre2_radioSettings;
} forEach f_radios_settings_acre2_radioChannels;