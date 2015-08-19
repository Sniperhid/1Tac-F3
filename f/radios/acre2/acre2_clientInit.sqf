// F3 - ACRE Clientside Initialisation
// Credits: Please see the F3 online manual (http://www.ferstaberinde.com/f3/en/)

// if dead, set spectator and exit
if(!alive player) exitWith {[true] call acre_api_fnc_setSpectator;};

_unit = player;

fn_numToColor = {
	params["_number"];
	_color = switch (_number) do {
		 case -1: {"#FFFFFF"};
		 case 0: {"#1AFF00"};
		 case 1: {"#0071FF"};
		 case 2: {"#E8DF06"};
        case 3: {"#06E8B1"};
		default {"#FFAB06"};
	};
	// return color
	_color
};

// ====================================================================================
// Set language of the units depending on side (BABEL API)

_languagesToSpeak = [] call f_radios_settings_acre_babel_assignment;
_languagesToSpeak call acre_api_fnc_babelSetSpokenLanguages;
[_languagesToSpeak select 0] call acre_api_fnc_babelSetSpeakingLanguage;

if (f_radios_settings_acre2_disableRadios) exitWith {};
      
// Wait for F3's assignGear to finish.
waitUntil{(player getVariable ["f_var_assignGear_done", false])};
_typeOfUnit = _unit getVariable ["f_var_assignGear", "NIL"];
_radiosToGive = [_unit,_typeOfUnit] call f_radios_settings_acre2_allocation;

// Setup the correct presets.

_ourPresetIndex = -1;

_channelsProcessed = []; // This will store channels, binned by radio type.
{ _channelsProcessed pushBack []; } forEach f_radios_settings_acre2_radioSettings;
_presetName = "default";

{
	_radioPresetSetting = _x;
	_condition = _radioPresetSetting select 0;
	if (call _condition) exitWith {
		//uses these presets.
		_ourPresetIndex = _forEachIndex;
		
		_presetName = format["f3preset%1",_ourPresetIndex];
		{
		   _radioList = _x select 0; // RadioList 
			{ [_x, _presetName] call acre_api_fnc_setPreset; } forEach (_radioList);
		} forEach f_radios_settings_acre2_radioSettings;
		
        for "_i" from 1 to (count _radioPresetSetting)-1 do {
            _channelEntry = _radioPresetSetting select _i;
            _radio = (_channelEntry select 2);
            _condition = (_channelEntry select 3);
            (_channelsProcessed select ([_radio] call f_acre2_radioBaseNameToSettingsIdx)) pushBack (_channelEntry + [call _condition]);    
        };
	};
} forEach f_radios_settings_acre2_radioChannels;
if (_ourPresetIndex == -1) then { systemChat "[Warning] F3-ACRE no preset assigned for myself"; };

// CONSTRUCT BRIEFING AND MATCH THE RADIO CHANNELS TO RADIOS, SO LATER WE CAN SET THEM ON THE MATCHE CHANNELS.

_assignedRadioChannels = []; { _assignedRadioChannels pushBack [_x,-1]; } forEach _radiosToGive; // 'ClassName','Chan num'
_usedRadioIndexs = []; // Used for tracking colours, so that we know which ones we have already used.
_ltext = "<font size='11'>Legend: <font color='#ff4747'>*</font> is used to denote a channel you are suppose to be on.<br/>The colours are used to match your radios with channels (your radios will be set to these channels), white radios will remain on channel 1.<br/>I can speak any languages that are <font color='#ff4747'>highlighted</font>.</font><br/><br/>";

// BRIEFING: LANGUAGES
_ltext = _ltext + "<font size='16'>BABEL - LANGUAGES</font><br/>Languages spoken in this area:<br/>";
{
  if (_forEachIndex != 0) then {_ltext = _ltext + ", "; };
  if ((_x select 0) in _languagesToSpeak) then {
      _ltext = _ltext + format["<font color='#ff4747'>%1</font>",_x select 1];
  } else {
      _ltext = _ltext + (_x select 1);
  };
} forEach f_radios_settings_acre2_languages;


_text = "<br/><font size='16'>RADIO CHANNEL LISTING</font>";
{
	_radioSettingsIndex = _forEachIndex;
	if (count (_channelsProcessed select _radioSettingsIndex) > 0) then { // If at least one channel is defined.
		_text = _text + "<br/>For: ";
		_radioFreqInfo = _x;
		_radioList = _radioFreqInfo select 0;
		_radio = (_radioList select 0);
		{
		  if (_forEachIndex != 0) then {_text = _text + ", "; };
		  _text = _text + getText (configfile >> "CfgWeapons" >> _x >> "displayName");

		} forEach _radioList;
		_text = _text + ":<br/>";                
	   
		
		{
		  _chanNum = _forEachIndex +1;
		  _frequency = [_radio, _presetName, _chanNum, "frequencyTX"] call acre_api_fnc_getPresetChannelField;
          if (_frequency >= 1000) then { 
            _frequency = [_frequency, 4,3] call CBA_fnc_formatNumber;  
          } else {
            if (_frequency < 100) then {
                _frequency = format[" %1",[_frequency, 2,5] call CBA_fnc_formatNumber];  
            } else {
                _frequency = [_frequency, 3,5] call CBA_fnc_formatNumber; 
            };
          };
		  _channelLine = format["CHN %1 (%2 MHz) - %3 - %4",_chanNum,_frequency,(_x select 0),(_x select 1)];
		_defaultRadio = (_x select 2);
		if (_x select 4) then { // if player is supposet to be on this channel
			  // Match radio to number...
			  _radioFndIdx = -1;
			  {
				  if (_radioFndIdx != -1) exitWith {};
				  _radioID = _forEachIndex;
				  if (!(_radioID in _usedRadioIndexs)) then {
					  if (_x in _radioList) then {
							_radioFndIdx = _radioID;
							_usedRadioIndexs pushBack _radioID;
						  (_assignedRadioChannels select _radioFndIdx) set [1,_chanNum];
					  };
				  };
			  } forEach _radiosToGive;
              // Give missing radio?
              if ((_radioFndIdx isEqualTo -1) && f_radios_settings_giveMissingRadios) then {
                    _radiosToGive pushBack _defaultRadio;
                    _assignedRadioChannels pushBack [_defaultRadio,_chanNum];
					_radioFndIdx = (count _radiosToGive)-1;
                    _usedRadioIndexs pushBack _radioFndIdx;
              };

			  _color = [_radioFndIdx] call fn_numToColor;
                _channelLine = " <font color='#ff4747'>*</font> " + format["<font color='%1'>",_color] + _channelLine + "</font><br/>";  
		  } else {
                _channelLine = "   " +_channelLine + "<br/>";
          };
		  _text = _text + _channelLine;
		} forEach (_channelsProcessed select _radioSettingsIndex);
	};
} forEach f_radios_settings_acre2_radioSettings;

_text2 = "<br/><br/><font size='16'>MY ASSIGNED RADIOS</font><br/>";
{
	_color = [_forEachIndex] call fn_numToColor;
	_text2 = _text2 + format["<font color='%1'>%2</font><br/>",_color,getText (configfile >> "CfgWeapons" >> _x >> "displayName")];
} forEach _radiosToGive;

_text = _ltext + _text2 + _text;

//Provide instructions on the page. such as * to denote a channel you are suppose to be on, explain what the colours mean.
player createDiaryRecord ["diary", ["ACRE2", _text]];    


// WAIT FOR NORMAL ACRE2 INIT>
waitUntil{uiSleep 0.3; !("ItemRadio" in (items _unit + assignedItems _unit))};
uiSleep 1;

waitUntil{[] call acre_api_fnc_isInitialized};
// Remove already initalized radios.
{_unit removeItem _x;} forEach ([] call acre_api_fnc_getCurrentRadioList);


// Allocate new radios.
{
	if (_unit canAdd _x) then {
		_unit addItem _x;
	} else {
		//Give the player a message so it isn't forgotten about during the briefing.
		[_x] spawn {
			waitUntil{time>3};
			systemChat format["[F3 ACRE2] Warning: No room to add radio '%1', report this to the mission maker. You now have an addaction to add the radio.",_this select 0];
		};
		
		//Create addAction to give radio.
		_radioName = getText (configfile >> "CfgWeapons" >> _x >> "displayName");
		_actionID = _unit addAction [format ["<t color='#3375D6'>[Radios] Give myself a %1 radio</t>",_radioName],
			 {
				 _radioToGive = (_this select 3) select 0;
				 _unit = (_this select 0),
				 if (_unit canAdd _radioToGive) then {
					_unit addItem _radioToGive;
					_unit removeAction (_this select 2);
				 } else {
					 systemChat format["[F3 ACRE2] Warning: No room to add radio '%1', remove more stuff and try again",_radioToGive];
				 };
			 }
			 ,[_x],0,false,false,"","(_target == _this)"];
		[_actionID,_unit] spawn {
			sleep 300;
			if (!isNull (_this select 1)) then {
				(_this select 1) removeAction (_this select 0);
			};
		};
	};
} forEach _radiosToGive;

waitUntil{[] call acre_api_fnc_isInitialized};

//Set all the radio channels to the correct ones.
_usedRadioIndexs = [];
_radioList = [] call acre_api_fnc_getCurrentRadioList;
{
	_radioName = _x;
	_baseRadio = [_x] call acre_api_fnc_getBaseRadio;
	{
		if (!(_forEachIndex in _usedRadioIndexs)) then {
			if (_baseRadio == (_x select 0)) then {
				if ((_x select 1) != -1) then {
					[_radioName,(_x select 1)] call acre_api_fnc_setRadioChannel;
				};
				_usedRadioIndexs pushBack _forEachIndex;
			};
		};
	} forEach (_assignedRadioChannels);
} forEach _radioList;


// Give addActions to addRadios.
if (!isNil "f_radios_settings_acre2_addActionRadios") then {
    {
        _actionid_action = _unit addAction [format["<t color='#c3d633'>[Radios] Give myself a %1 radio (check your inventory for space)</t>",getText (configfile >> "CfgWeapons" >> _x >> "displayName")], 
                                            format["if ((_this select 0) canAdd '%1') then { (_this select 0) addItem '%1'; (_this select 0) removeAction (_this select 2); } else { systemChat '[F3 ACRE2] No space for radios'; };",_x],0,0,false,true,"","(_target == _this)"];
        [_actionid_action,_unit] spawn {
            sleep 300;
            if (!isNull (_this select 1)) then {
                (_this select 1) removeAction (_this select 0);
            };
        };
    } forEach f_radios_settings_acre2_addActionRadios;
};
