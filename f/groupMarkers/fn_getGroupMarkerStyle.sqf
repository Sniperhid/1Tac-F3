private ["_size","_input","_texture","_color"];
// ====================================================================================
// data values

_input = _this select 0;
_texture = "";
_color = [1,1,1,1];
_size = [32,32];

switch true do {
	case (_input in ["1PLT"]): {
		_texture = "\f3_groupmarkers\textures\yellow.paa";
	};
	case (_input in ["CO"]): {
		_texture = "\f3_groupmarkers\textures\yellow_hq.paa";
	};
	case (_input in ["DC"]): {
		_texture = "\f3_groupmarkers\textures\yellow_chevrons.paa";
	};
	case (_input in ["ASL"]): {
		_texture = "\f3_groupmarkers\textures\red_sl_flag.paa";
		_size = [24,24];
	};
	case (_input in ["A","A1","A2","A3"]): {
		_texture = "\f3_groupmarkers\textures\red_inf.paa";
	};
	case (_input in ["BSL"]): {
		_texture = "\f3_groupmarkers\textures\blue_sl_flag.paa";
		_size = [24,24];
	};
	case (_input in ["B","B1","B2","B3"]): {
		_texture = "\f3_groupmarkers\textures\blue_inf.paa";
	};
	case (_input in ["CSL"]): {
		_texture = "\f3_groupmarkers\textures\green_sl_flag.paa";
		_size = [24,24];
	};
	case (_input in ["C","C1","C2","C3"]): {
		_texture = "\f3_groupmarkers\textures\green_inf.paa";
	};
	case (_input in ["MMG1","MMG2","MMG3"]): {
		_texture = "\f3_groupmarkers\textures\yellow_mg_m.paa";
	};
	case (_input in ["HMG1","HMG2","HMG3"]): {
		_texture = "\f3_groupmarkers\textures\yellow_mg_h.paa";
	};
	case (_input in ["MAT1","MAT2","MAT3"]): {
		_texture = "\f3_groupmarkers\textures\yellow_antitank.paa";
	};
	case (_input in ["HAT1","HAT2","HAT3"]): {
		_texture = "\f3_groupmarkers\textures\yellow_antitank_rocket.paa";
	};
	case (_input in ["MTR1","MTR2","MTR3"]): {
		_texture = "\f3_groupmarkers\textures\yellow_mortar.paa";
	};
	case (_input in ["MSAM1","MSAM2","MSAM3"]): {
		_texture = "\f3_groupmarkers\textures\yellow_airdef_not_a_nipple.paa"; 
	};
	case (_input in ["HSAM1","HSAM2","HSAM3"]): {
		_texture = "\f3_groupmarkers\textures\yellow_airdef_not_a_nipple.paa";
	};
	case (_input in ["ST1","ST2","ST3"]): {
		_texture = "\f3_groupmarkers\textures\yellow_recon.paa";
	};
	case (_input in ["DT1","DT2","DT3"]): {
		_texture = "\f3_groupmarkers\textures\yellow_sf.paa";
	};
	case (_input in ["ENG1","ENG2","ENG3"]): {
		_texture = "\f3_groupmarkers\textures\yellow_engineer.paa";
	};
	case (_input in ["IFV1","IFV2"]): {
		_texture = "\f3_groupmarkers\textures\red_inf_mech.paa";
	};
	case (_input in ["IFV3","IFV4"]): {
		_texture = "\f3_groupmarkers\textures\blue_inf_mech.paa";
	};
	case (_input in ["IFV5","IFV6"]): {
		_texture = "\f3_groupmarkers\textures\green_inf_mech.paa";
	};
	case (_input in ["IFV7","IFV8"]): {
		_texture = "\f3_groupmarkers\textures\yellow_inf_mech.paa";
	};
	case (_input in ["TNK1","TNK2","TNK3"]): {
		_texture = "\f3_groupmarkers\textures\red_armor.paa";
	};
	case (_input in ["TH1","TH2"]): {
		_texture = "\f3_groupmarkers\textures\red_helo_cargo.paa";
	};
	case (_input in ["TH3","TH4"]): {
		 _texture = "\f3_groupmarkers\textures\blue_helo_cargo.paa";
	};
	case (_input in ["TH5","TH6"]): {
		 _texture = "\f3_groupmarkers\textures\green_helo_cargo.paa";
	};
	case (_input in ["TH7","TH8"]): {
		 _texture = "\f3_groupmarkers\textures\yellow_helo_cargo.paa";
	};
	case (_input in ["AH1","AH2","AH3"]): {
		 _texture = "\f3_groupmarkers\textures\yellow_helo_attack.paa";
	};
	case (_input in ["AM"]): {
		_texture = "\f3_groupmarkers\textures\red_cross.paa";
		_color = [1,1,1,0.9];
		_size = [18,18];
	};
	case (_input in ["BM"]): {
		_texture = "\f3_groupmarkers\textures\blue_cross.paa";
		_color = [1,1,1,0.9];
		_size = [18,18];
	};
	case (_input in ["CM"]): {
		_texture = "\f3_groupmarkers\textures\green_cross.paa";
		_color = [1,1,1,0.9];
		_size = [18,18];
	};
	case (_input in ["COM","DCM","AM","BM","CM"]): {
		_texture = "\f3_groupmarkers\textures\yellow_cross.paa";
		_color = [1,1,1,0.9];
		_size = [18,18];
	};
	case (_input)
};

[_texture,_color,_size]