// F3 - ACRE2 Settings
// Credits: Please see the F3 online manual (http://www.ferstaberinde.com/f3/en/)
// ====================================================================================

// ====================================================================================
// BABEL API

// Defines the languages that exist in the mission.
// string id, displayname
f_radios_settings_acre2_languages = [["english","English"],["farsi","Farsi"],["greek","Greek"]];

// Defines the language that a player can speak. Every unit should have at least one language they can speka.
f_radios_settings_acre_babel_assignment = {
    _languagesToSpeak = [];
    
    switch (side _unit) do {
        case west: { _languagesToSpeak pushBack "english";};
        case east: { _languagesToSpeak pushBack "farsi";};
        case resistance: { _languagesToSpeak pushBack "greek";};
        default { _languagesToSpeak pushBack "greek"};
    };
    
    _languagesToSpeak // return list of languages to speak.
};

// ====================================================================================
// RADIO GENERAL SETTINGS STRUCTURE

// Whether any radios should be assigned at all, to any units
// TRUE = Disable radios for all units
f_radios_settings_acre2_disableRadios = false;

// ACRE Radio loss settings.
// Indiciates how much terrian loss should be modelled.
// Values: 0 no loss, 1 full terrian loss, default: 1
[1] call acre_api_fnc_setLossModelScale;

// ACRE full Duplex
// Sets the duplex of radio transmissions. If set to true, it means that you will receive transmissions even while talking and multiple people can speak at the same time.
[false] call acre_api_fnc_setFullDuplex;

// ACRE Interference
// Sets whether transmissions will interfere with eachother. This, by default, causes signal loss when multiple people are transmitting on the same frequency.
[true] call acre_api_fnc_setInterference;

// ACRE can AI hear players?
// False - AI not hear players, true - AI hear players.
[false] call acre_api_fnc_setRevealToAI;


// ====================================================================================
// RADIO ALLOCATION
// The function below will be called by the radio allocator, it expects an array of radios to be returned.
//

f_radios_settings_acre2_allocation = {
	_radiosToGive = [];
	_unit = _this select 0;
	_typeOfUnit = _this select 1;
    
	// Give everyone a 343.
	_radiosToGive pushBack "ACRE_PRC343";
    

	if (_typeOfUnit in ["co","dc","fac","ftl","m","fac"]) then {
		_radiosToGive pushBack "ACRE_PRC148";   
	};
	if (_typeOfUnit in ["fac"]) then {
		_radiosToGive pushBack "ACRE_PRC117F";
	};
    //_radiosToGive pushBack "ACRE_PRC148";
    //_radiosToGive pushBack "ACRE_PRC152";
	_radiosToGive // return list of radios to give.
};

// ====================================================================================
// RADIO PRESET AND CHANNEL ALLOCATION


//Each preset becomes its own. 
// LIMITATION: each _unit should only have one preset type. the first matching preset will always be used.
f_radios_settings_acre2_radioChannels = [
	// Batched by Preset (First entry of every preset is condition to use the preset)
	// chn entry: NAME, DESCRIPTION, RADIO_TYPE, condition for being on the channel
	[   // 0
		{toLower (faction _unit) == "blu_f"}, //Condition for using the preset.
		["Alpha","Alpha Squad Net","ACRE_PRC343",{[_unit,"ASL","A1","A2","A3"] call f_isUnitInGroupArray}],
		["Bravo","Bravo Squad Net","ACRE_PRC343",{[_unit,"BSL","B1","B2","B3"] call f_isUnitInGroupArray}],
		["Charlie","Charlie Squad Net","ACRE_PRC343",{[_unit,"CSL","C1","C2","C3"] call f_isUnitInGroupArray}],
		["1PLT-COM","Platoon Command Net","ACRE_PRC148",{([_unit,"CO","SGT","ASL","BSL","CSL","WSL"] call f_isUnitLeaderInGroupArray) or (_typeOfUnit in ["m","pp","vc","jp","fac"])}]             
	],
	[   // 1
		{side _unit == east},
		["Alpha","Alpha Squad Net","ACRE_PRC343",{[_unit,"ASL","A1","A2","A3"] call f_isUnitInGroupArray}],
		["Bravo","Bravo Squad Net","ACRE_PRC343",{[_unit,"BSL","B1","B2","B3"] call f_isUnitInGroupArray}],
		["Charlie","Charlie Squad Net","ACRE_PRC343",{[_unit,"CSL","C1","C2","C3"] call f_isUnitInGroupArray}],
		["1PLT-COM","Platoon Command Net","ACRE_PRC148",{([_unit,"CO","SGT","ASL","BSL","CSL","WSL"] call f_isUnitLeaderInGroupArray) or (_typeOfUnit in ["m","pp","vc","jp","fac"])}]                 
	],
	[   // 2
		{side _unit == resistance}, 
		["Alpha","Alpha Squad Net","ACRE_PRC343",{[_unit,"ASL","A1","A2","A3"] call f_isUnitInGroupArray}],
		["Bravo","Bravo Squad Net","ACRE_PRC343",{[_unit,"BSL","B1","B2","B3"] call f_isUnitInGroupArray}],
		["Charlie","Charlie Squad Net","ACRE_PRC343",{[_unit,"CSL","C1","C2","C3"] call f_isUnitInGroupArray}],
		["1PLT-COM","Platoon Command Net","ACRE_PRC148",{([_unit,"CO","SGT","ASL","BSL","CSL","WSL"] call f_isUnitLeaderInGroupArray) or (_typeOfUnit in ["m","pp","vc","jp","fac"])}]          
	],
	[   // 3
		{toLower (faction _unit) == "blu_g_f"},
		["Alpha","Alpha Squad Net","ACRE_PRC343",{[_unit,"ASL","A1","A2","A3"] call f_isUnitInGroupArray}],
		["Bravo","Bravo Squad Net","ACRE_PRC343",{[_unit,"BSL","B1","B2","B3"] call f_isUnitInGroupArray}],
		["Charlie","Charlie Squad Net","ACRE_PRC343",{[_unit,"CSL","C1","C2","C3"] call f_isUnitInGroupArray}],
		["1PLT-COM","Platoon Command Net","ACRE_PRC148",{([_unit,"CO","SGT","ASL","BSL","CSL"] call f_isUnitLeaderInGroupArray) or (_typeOfUnit in ["m","pp","vc","jp","fac"])}]           
	]
];

//Special channels are for channels that go across multiple presets, to allow communications between different factions/teams.
f_radios_settings_acre2_special_radioChannels = [
    // Presets, channel should be accesible in, DETAILS, CONDITIONS OF BEING IN IT. EXAMPLE BELOW:
	//[[0,3],"NATO n FIA","FIA and NATO Liason Net","ACRE_PRC148",{_typeOfUnit in ["co"]}]
];

// If the unit doesn't have enough radios to access the channels they are meant to be on, shall we give them radios (will give the  default radio for the channel).
f_radios_settings_giveMissingRadios = true;

// Provide these radios on a scroll wheel action, disable set to []
f_radios_settings_acre2_addActionRadios = ["ACRE_PRC343","ACRE_PRC148"];

// This are the core radio settings, it is advisiable to not touch this.
f_radios_settings_acre2_radioSettings = [
		// Array of Radio names, min freq, max freq, freq step, freq spacing between channels (for channel allocation), default preset name to copy
		[["ACRE_PRC343"],2400,2420,0.01,0.1,"default2"],
		[["ACRE_PRC148","ACRE_PRC152","ACRE_PRC117F"],60,360,0.00625,1,"default"]//,
	 //   [["ACRE_PRC77"],30,75.95,0.05,5] <- Doesn't support preset assignment.
	];

