//////////////////////////////////////////////////////
//
//             F3 - RESPAWN SETTINGS
//         Credits: Snippers, Head & 1Tac
//
//////////////////////////////////////////////////////

// To open the respawn dialog just call from the debug console (even in spectator):
//   createDialog "respawnMenuDialog";

///////////// RESPAWN ROLE SETTINGS

// These are the roles that area shown in the respawn GUI.
// Format: AssignGear Role, GUI Display Name

respawnMenuRoles = [
    ["ftl","Fireteam Leader"],
    ["ar","Automatic Rifleman"],
    ["aar","Assistant Automatic Rifleman"],
    ["rat","Rifleman: Antitank"],
    ["m","Medic"],
    ["dc","Squad Leader"],
    ["mmgg","MMG - Gunner"],
    ["mmgag","MMG - Assistant Gunner"],
    ["matg","MAT - Gunner"],
    ["matag","MAT - Assistant Gunner"],
    ["eng","Engineer (Demo)"],
    ["engm","Engineer (Mines)"],
    ["uav","UAV Operator"],
    ["vc","Crewman - Vehicle Commander"],
    ["vg","Crewman - Vehicle Gunner"],
    ["vd","Crewman - Vehicle Driver"],
    ["pp","Aircrewman - Pilot"],
    ["pcc","Aircrewman - Co-Pilot (Repair)"],
    ["pc","Aircrewman"],
    ["co","Commander"]
];

///////////// FACTION SETTINGS

// Factions that will appear in the respawn GUI.
// These MUST be defined in CfgFactionClasses

respawnMenuFactions = [
    ["blu_f","NATO"],
    ["opf_f","CSAT"],
    ["ind_f","AAF"],
    ["blu_g_f","Blufor - FIA"]   
];

// Respawn Classes
// This function is designed to choose the classname of a new unit based on the faction and specified unit type.
// This is important as the ability to perform certain tasks can be derived from being a certain class.

fn_respawnSelectClass = {
    _faction = _this select 0;
    _typeOfUnit = _this select 1;
    
    //Setup a default value.
    _type = "C_man_1";

    switch (_faction) do {
        case "blu_f": {
            switch (_typeOfUnit) do {
                case "m":{ _type = "B_medic_F"; };
                case "eng":{ _type = "B_engineer_F"; };
                case "engm":{ _type = "B_engineer_F"; };
                case "vd":{ _type = "B_soldier_repair_F"; };
                case "pcc":{ _type = "B_soldier_repair_F"; };
                default  { _type = "B_Soldier_02_f"; };
            };
        };
        case "opf_f":{
            switch (_typeOfUnit) do {
                case "m":{ _type = "O_medic_F"; };
                case "eng":{ _type = "O_engineer_F"; };
                case "engm":{ _type = "O_engineer_F"; };
                case "vd":{ _type = "O_soldier_repair_F"; };
                case "pcc":{ _type = "O_soldier_repair_F"; };
                default  { _type = "O_Soldier_F"; };
            };
        };
        case "ind_f": {
            switch (_typeOfUnit) do {
                case "m":{ _type = "I_medic_F"; };
                case "eng":{ _type = "I_engineer_F"; };
                case "engm":{ _type = "I_engineer_F"; };
                case "vd":{ _type = "I_soldier_repair_F"; };
                case "pcc":{ _type = "I_soldier_repair_F"; };
                default  { _type = "I_Soldier_A_F"; };
            };
        };
        case "blu_g_f" : {
            switch (_typeOfUnit) do {
                case "m":{ _type = "B_G_medic_F"; };
                case "eng":{ _type = "B_G_engineer_F"; };
                case "engm":{ _type = "B_G_engineer_F"; };
                case "vd":{ _type = "B_G_engineer_F"; };
                case "pcc":{ _type = "B_G_engineer_F"; };
                default  { _type = "B_G_Soldier_F"; };
            };
        };
        default { _type = "C_man_1"; };
    };
    
    // Return the value of _type
    _type
};

///////////// MARKER SETTINGS

// Possible marker icons
// Format: Texture path, GUI marker display name.

respawnMenuMarkers = [
    ["\A3\ui_f\data\map\markers\nato\b_hq.paa","HQ"],
    ["\A3\ui_f\data\map\markers\nato\b_inf.paa","Infantry"],
    ["\A3\ui_f\data\map\markers\nato\b_support.paa","MG Team"],
    ["\A3\ui_f\data\map\markers\nato\b_motor_inf.paa","Missle (AT/AA) Team"],
    ["\A3\ui_f\data\map\markers\nato\b_recon.paa","Sniper"],
    ["\A3\ui_f\data\map\markers\nato\b_mortar.paa","Mortar Team"],
    ["\A3\ui_f\data\map\markers\nato\b_motor_inf.paa","APC/IFV"],
    ["\A3\ui_f\data\map\markers\nato\b_armor.paa","Armour"],
    ["\A3\ui_f\data\map\markers\nato\b_air.paa","Heli"],
    ["\A3\ui_f\data\map\markers\nato\b_plane.paa","Airplane/Jet"]   
];

// Respawn Marker Colours
// Format [r,g,b,alpha], GUI display name.

respawnMenuMarkerColours = [
    [[1,0,0,1],"Red"],
    [[0,0,1,1],"Blue"],
    [[0,1,0,1],"Green"],
    [[1,0.647,0,1],"Orange"],
    [[1,1,0,1],"Yellow"],
    [[0,0,0,1],"Black"],
    [[1,1,1,1],"White"]
];