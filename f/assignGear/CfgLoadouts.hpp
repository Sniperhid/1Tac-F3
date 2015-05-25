
#define list_1(thing) thing
#define list_2(thing) list_1(thing), thing
#define list_3(thing) list_2(thing), thing
#define list_4(thing) list_3(thing), thing
#define list_5(thing) list_4(thing), thing
#define list_6(thing) list_5(thing), thing
#define list_7(thing) list_6(thing), thing
#define list_8(thing) list_7(thing), thing
#define list_9(thing) list_8(thing), thing
#define list_10(thing) list_9(thing), thing
#define list_11(thing) list_10(thing), thing
#define list_12(thing) list_11(thing), thing
#define list_13(thing) list_12(thing), thing
#define list_14(thing) list_13(thing), thing
#define list_15(thing) list_14(thing), thing
#define list_16(thing) list_15(thing), thing
#define list_17(thing) list_16(thing), thing
#define list_18(thing) list_17(thing), thing
#define list_19(thing) list_18(thing), thing
#define list_20(thing) list_19(thing), thing
#define list_21(thing) list_20(thing), thing
#define list_22(thing) list_21(thing), thing
#define list_23(thing) list_22(thing), thing
#define list_24(thing) list_23(thing), thing
#define list_25(thing) list_24(thing), thing
#define list_26(thing) list_25(thing), thing
#define list_27(thing) list_26(thing), thing
#define list_28(thing) list_27(thing), thing
#define list_29(thing) list_28(thing), thing
#define list_30(thing) list_29(thing), thing
#define list_31(thing) list_30(thing), thing
#define list_32(thing) list_31(thing), thing
#define list_33(thing) list_32(thing), thing
#define list_34(thing) list_33(thing), thing
#define list_35(thing) list_34(thing), thing

class blu_f {
    //Rifle
    #define RIFLE "rhs_weap_m4a1_carryhandle_grip2"
    #define RIFLE_MAG "rhs_mag_30Rnd_556x45_Mk318_Stanag"
    #define RIFLE_MAG_TR "rhs_mag_m18_red"
    //GL Rifle
    #define GLRIFLE "rhs_weap_m4a1_carryhandle_m203S"
    #define GLRIFLE_MAG "rhs_mag_30Rnd_556x45_Mk318_Stanag"
    #define GLRIFLE_MAG_TR RIFLE_MAG_TR
    #define GLRIFLE_MAG_SMOKE list_4("1Rnd_Smoke_Grenade_shell"),list_2("1Rnd_SmokeGreen_Grenade_shell"),list_3("1Rnd_SmokeRed_Grenade_shell")
    #define GLRIFLE_MAG_HE list_8("rhs_mag_M433_HEDP")
    #define GLRIFLE_MAG_FLARE list_2("UGL_FlareRed_F"),list_2("UGL_FlareGreen_F")
    //Carbine
    #define CARBINE "rhs_weap_m4a1_carryhandle_grip"
    #define CARBINE_MAG RIFLE_MAG
    #define CARBINE_MAG_TR RIFLE_MAG_TR
    // AR
    #define AR "rhs_weap_m249_pip"
    #define AR_MAG "rhsusf_200Rnd_556x45_soft_pouch"
    // AT
    #define AT "rhs_weap_M136"
    #define AT_MAG "rhs_m136_mag"
    // MMG
    #define MMG "rhs_weap_m240B"
    #define MMG_MAG "rhsusf_100Rnd_762x51"
    // MAT
    #define MAT "launch_B_Titan_short_F"
    #define MAT_MAG "Titan_AT"
    // SAM
    #define SAM "rhs_weap_fim92"
    #define SAM_MAG "rhs_fim92_mag"
    // Sniper Rifle
    #define SNIPER "RH_m110"
    #define SNIPER_MAG "RH_20Rnd_762x51_Mk316LR"
    // Spotter Rifle
    #define SPOTTER "rhs_weap_m4a1_blockII_grip2_KAC"
    #define SPOTTER_MAG RIFLE_MAG
    // SMG
    #define SMG "hlc_smg_mp5a4"
    #define SMG_MAG "hlc_30Rnd_9x19_B_MP5"
    // Pistol
    #define PISTOL "rhsusf_weap_m1911a1"
    #define PISTOL_MAG "rhsusf_mag_7x45acp_MHP"
    // Frag
    #define GRENADE "rhs_mag_m67"
    #define SMOKE_GRENADE "rhs_mag_an_m8hc"
    
    #define BASE_ITEMS "ItemMap","ItemCompass","ItemWatch"
    #define BASE_MEDICAL list_4("ACE_fieldDressing"),"ACE_morphine"

    class r {// rifleman
        uniform[] = {"rhs_uniform_cu_ocp"};  /// randomized
        vest[] = {"rhsusf_iotv_ocp_Rifleman","rhsusf_iotv_ocp_Repair","rhsusf_iotv_ocp_Teamleader"}; /// randomized
        headgear[] = {"rhsusf_ach_helmet_ocp","rhsusf_ach_helmet_ESS_ocp"}; /// randomized
        backpack[] = {"rhsusf_assault_eagleaiii_ocp"}; /// randomized
        goggles[] = {}; // randomized

        primaryWeapons[] = {RIFLE}; /// randomized
        scopes[] = {"rhsusf_acc_eotech_552"}; // randomized
        bipods[] = {}; // randomized
        attachments[] = {"rhsusf_acc_anpeq15side"}; // randomized
        silencers[] = {}; // randomized
            
        secondaryWeapons[] = {}; /// randomized
        secondaryAttachments[] = {};
        sidearmWeapons[] = {}; /// randomized
        sidearmAttachments[] = {};
        
        magazines[] = {list_8(RIFLE_MAG),
                       list_2(RIFLE_MAG_TR),
                       list_2(GRENADE),
                       list_2(SMOKE_GRENADE)};
        
        items[] = {BASE_MEDICAL};
        linkedItems[] = {BASE_ITEMS,"rhsusf_ANPVS_14"};
        backpackItems[] = {"ACE_IR_Strobe_item"}; // must be in rucksack
        backpackMagazines[] = {}; // Must be in rucksack
    };
    class dc : r {// CO and DC
        primaryWeapons[] = {GLRIFLE};
        vest[] = {"rhsusf_iotv_ocp_Grenadier"}; /// randomized
        headgear[] = {"rhsusf_ach_helmet_headset_ocp"}; /// randomized
        magazines[] = {list_8(GLRIFLE_MAG),
                       list_2(GLRIFLE_MAG_TR),
                       GLRIFLE_MAG_HE,
                       GLRIFLE_MAG_SMOKE,
                       GLRIFLE_MAG_FLARE,
                       list_4(PISTOL_MAG),
                       list_2(GRENADE),
                       list_2(SMOKE_GRENADE),
                       list_2("rhs_mag_m18_green")};
        sidearmWeapons[] = {PISTOL}; /// randomized
        backpackItems[] = {"ACE_IR_Strobe_item","ACE_key_west"};
        linkedItems[] = {BASE_ITEMS,"ACE_Vector"};
        items[] = {BASE_MEDICAL,"ACE_MapTools"};
    };
    class co : dc {
        
    };
    class uav : r {
        backpack[] = {"B_rhsusf_B_BACKPACK"}; /// randomized
        linkedItems[] = {BASE_ITEMS,"B_uavterminal"};
    };
    class ftl : r {// FTL
        primaryWeapons[] = {GLRIFLE};
        headgear[] = {"rhsusf_ach_helmet_headset_ess_ocp"}; /// randomized
        magazines[] = {list_8(GLRIFLE_MAG),
                       list_2(GLRIFLE_MAG_TR),
                       GLRIFLE_MAG_HE,
                       GLRIFLE_MAG_SMOKE,
                       GLRIFLE_MAG_FLARE,
                       list_2("rhs_mag_m18_green"),
                       list_2(GRENADE),
                       list_2(SMOKE_GRENADE),
                       list_2(GRENADE),
                       list_2(SMOKE_GRENADE)};
        backpackItems[] = {"ACE_IR_Strobe_item","ACE_key_west"};
        linkedItems[] = {BASE_ITEMS,"ItemGPS","Binocular"};
    };
    class ar : r {// AR
        vest[] = {"rhsusf_iotv_ocp_SAW"}; /// randomized
        primaryWeapons[] = {AR};
        magazines[] = {list_2(AR_MAG),
                       list_4(PISTOL_MAG),
                       list_2(GRENADE),
                       list_2(SMOKE_GRENADE)};
        sidearmWeapons[] = {PISTOL}; /// randomized
    };
    class aar : r {// AAR
        backpackMagazines[] = {list_2(AR_MAG)};
        scopes[] = {"rhsusf_acc_ACOG_USMC"};
        linkedItems[] = {BASE_ITEMS,"Binocular"};
    };
    class rat : r {// RAT
        primaryWeapons[] = {CARBINE};
        magazines[] = {list_8(CARBINE_MAG),
                       list_2(CARBINE_MAG_TR),
                       AT_MAG,
                       list_2(GRENADE),
                       list_2(SMOKE_GRENADE)};
        secondaryWeapons[] = {AT}; /// randomized
    };
    class m: r {// Medic
        vest[] = {"rhsusf_iotv_ocp_medic"}; /// randomized
        primaryWeapons[] = {CARBINE};
        magazines[] = {list_8(CARBINE_MAG),
                       list_2(CARBINE_MAG_TR),
                       list_6(SMOKE_GRENADE)};
        backpackItems[] = {list_31("ACE_fieldDressing"),list_8("ACE_epinephrine"),list_2("ACE_bloodIV"),list_14("ACE_morphine")};
    };
    class mmgg : r {// MMG
        primaryWeapons[] = {MMG};
        magazines[] = {list_5(MMG_MAG),
                       list_4(PISTOL_MAG),
                       GRENADE,
                       list_2(SMOKE_GRENADE)};
        sidearmWeapons[] = {PISTOL}; /// randomized
        scopes[] = {};
        attachements[] = {};
    };
    class mmgag : r {// MMG Spotter/Ammo Bearer
        backpackMagazines[] = {list_5(MMG_MAG)};
        linkedItems[] = {BASE_ITEMS,"ACE_Vector"};
    };
    class matg : r {// MAT Gunner
        primaryWeapons[] = {CARBINE};
        magazines[] = {list_8(CARBINE_MAG),
                       list_2(CARBINE_MAG_TR),
                       list_2(GRENADE),
                       list_2(SMOKE_GRENADE)};
        secondaryWeapons[] = {MAT}; /// randomized
        backpackItems[] = {list_3(MAT_MAG)};
    };
    class matag : r {// MAT Spotter/Ammo Bearer
        backpackItems[] = {list_3(MAT_MAG)};
        linkedItems[] = {BASE_ITEMS,"ACE_Vector"};
    };
    class hatg : r {// MAT Gunner
        primaryWeapons[] = {CARBINE};
        magazines[] = {list_8(CARBINE_MAG),
                       list_2(CARBINE_MAG_TR),
                       list_2(GRENADE),
                       list_2(SMOKE_GRENADE)};
        secondaryWeapons[] = {MAT}; /// randomized
        backpackItems[] = {list_3(MAT_MAG)};
    };
    class hatag : r {// MAT Spotter/Ammo Bearer
        backpackItems[] = {list_3(MAT_MAG)};
        linkedItems[] = {BASE_ITEMS,"ACE_Vector"};
    };
    class msamg : r {// SAM Gunner
        primaryWeapons[] = {CARBINE};
        magazines[] = {list_8(CARBINE_MAG),
                       list_2(CARBINE_MAG_TR),
                       list_2(GRENADE),
                       list_2(SMOKE_GRENADE)};
        secondaryWeapons[] = {SAM}; /// randomized
        backpackItems[] = {"ACE_IR_Strobe_item",list_2(SAM_MAG)};
    };
    class msamag : r {// SAM Spotter/Ammo Bearer
        backpackItems[] = {list_2(SAM_MAG)};
        linkedItems[] = {BASE_ITEMS,"ACE_Vector"};
    };
    class hsamg : r {// SAM Gunner
        primaryWeapons[] = {CARBINE};
        magazines[] = {list_8(CARBINE_MAG),
                       list_2(CARBINE_MAG_TR),
                       list_2(GRENADE),
                       list_2(SMOKE_GRENADE)};
        secondaryWeapons[] = {SAM}; /// randomized
        backpackItems[] = {"ACE_IR_Strobe_item",list_2(SAM_MAG)};
    };
    class hsamag : r {// SAM Spotter/Ammo Bearer
        backpackItems[] = {list_2(SAM_MAG)};
        linkedItems[] = {BASE_ITEMS,"ACE_Vector"};
    };
    class mtrg : r {// Mortar Gunner
        primaryWeapons[] = {CARBINE};
        magazines[] = {list_8(CARBINE_MAG),
                       list_2(CARBINE_MAG_TR),
                       list_2(GRENADE),
                       list_2(SMOKE_GRENADE)};
        backpack[] = {"B_Mortar_01_weapon_F"}; /// randomized
    };
    class mtrag : r {// Assistant Mortar
        backpack[] = {"B_Mortar_01_support_F"}; /// randomized
        linkedItems[] = {BASE_ITEMS,"ACE_Vector"};
    };
    class sp {// Spotter
        uniform[] = {"U_B_CombatUniform_mcam"};  /// randomized
        vest[] = {"rhsusf_iotv_ocp"}; /// randomized
        headgear[] = {"rhs_Booniehat_ocp","rhsusf_ach_helmet_ESS_ocp"}; /// randomized
        primaryWeapons[] = {SPOTTER}; /// randomized
        magazines[] = {list_8(SPOTTER_MAG),
                       list_2(SMOKE_GRENADE),
                       list_2(GRENADE)};
        linkedItems[] = {BASE_ITEMS,"itemGPS","LaserDesignator"};
        scopes[] = {"rhsusf_acc_eotech_552"};
        attachments[] = {"rhsusf_acc_anpeq15side"};
    };
    class sn : sp {// Sniper
        primaryWeapons[] = {SNIPER}; /// randomized
        magazines[] = {list_8(SNIPER_MAG),
                       list_2(SMOKE_GRENADE),
                       list_2(GRENADE)};
        linkedItems[] = {BASE_ITEMS,"itemGPS"};
        scopes[] = {"rhsusf_acc_LEUPOLDMK4_2"};
        attachments[] = {"rhsusf_acc_anpeq15side"};
        silencers[] = {"RH_m110sd_t"};
    };
    class pp { // Pilot
        uniform[] = {"U_B_HeliPilotCoveralls"};  /// randomized
        backpack[] = {};
        vest[] = {"V_TacVest_blk"}; /// randomized
        headgear[] = {"H_PilotHelmetHeli_B"}; /// randomized
        primaryWeapons[] = {SMG}; /// randomized
        magazines[] = {list_6(SMG_MAG),
                       list_2(SMOKE_GRENADE)};
        backpackItems[] = {"ACE_key_west"};
        linkedItems[] = {BASE_ITEMS,"itemGPS","NVgoggles"};
        items[] = {BASE_MEDICAL};
    };
    class pcc: pp { // Co-Pilot/Crew-Chief

    };
    class pc: pp { // AirCrew

    };
    class vg {// Crew
        uniform[] = {"U_B_CombatUniform_mcam"};  // randomized
        vest[] = {"rhsusf_iotv_ocp"}; // randomized
        headgear[] = {"rhsusf_ach_helmet_headset_ocp"}; /// randomized
        backpack[] = {};
        primaryWeapons[] = {CARBINE}; /// randomized
        magazines[] = {list_8(CARBINE_MAG),
                       list_2(CARBINE_MAG_TR),
                       list_2(SMOKE_GRENADE)};
        items[] = {BASE_MEDICAL,"ACE_key_west"};
        linkedItems[] = {BASE_ITEMS};
    };
    class vd: vg {// Repair Specialist
        backpack[] = {"B_Carryall_mcamo"};
        backpackItems[] = {"Toolkit"};
        vest[] = {"rhsusf_iotv_ocp_repair"}; /// randomized
    };
    class vc: vg {// Repair Specialist
        backpack[] = {"B_Carryall_mcamo"};
        backpackItems[] = {"Toolkit"};
        vest[] = {"rhsusf_iotv_ocp_repair"}; /// randomized
        linkedItems[] = {BASE_ITEMS,"itemGPS"};
    };
    class eng : r {// Explosive Specialist
        vest[] = {"rhsusf_iotv_ocp_repair"}; /// randomized
        primaryWeapons[] = {CARBINE}; /// randomized
        backpack[] = {"B_Carryall_mcamo"};
        backpackItems[] = {"Toolkit","ACE_DefusalKit","ACE_Clacker","MineDetector"};
        magazines[] = {list_8(CARBINE_MAG),
                       list_2(CARBINE_MAG_TR),
                       list_3("DemoCharge_Remote_Mag"),
                       list_2("SatchelCharge_Remote_Mag")};
    };
    class engm : eng {// Mine Specialist
        magazines[] = {list_8(CARBINE_MAG),
                       list_2(CARBINE_MAG_TR),
                       list_2("ATMine_Range_Mag"),
                       list_2("APERSBoundingMine_Range_Mag"),
                       list_2("APERSMine_Range_Mag")};
    };
    class div : r {
        uniform[] = {"U_B_Wetsuit"};  /// randomized
        vest[] = {"V_RebreatherB"}; /// randomized
        headgear[] = {}; /// randomized
        backpack[] = {"B_AssaultPack_blk"}; /// randomized
        goggles[] = {"G_Diving"}; // randomized

        primaryWeapons[] = {"arifle_SDAR_F"}; /// randomized
        scopes[] = {}; // randomized
        attachments[] = {}; // randomized
            

        
        magazines[] = {list_4("30Rnd_556x45_Stanag"),
                       list_3("20Rnd_556x45_UW_mag"),
                       list_2(GRENADE),
                       list_2(SMOKE_GRENADE)};
        
        items[] = {BASE_MEDICAL};
        linkedItems[] = {BASE_ITEMS,"rhsusf_ANPVS_14"};
        backpackItems[] = {"ACE_IR_Strobe_item"}; // must be in rucksack
        backpackMagazines[] = {}; // Must be in rucksack       
    };

    class hmgg : r {// MMG
        primaryWeapons[] = {CARBINE};
        magazines[] = {list_6(CARBINE_MAG),
                       list_4(PISTOL_MAG),
                       GRENADE,
                       list_2(SMOKE_GRENADE)};
        sidearmWeapons[] = {PISTOL}; /// randomized
        backpacks[] = {"RHS_M2_Gun_Bag"};
        scopes[] = {};
        attachements[] = {};
    };
    class hmgag : r {// MMG Spotter/Ammo Bearer
        primaryWeapons[] = {CARBINE};
        magazines[] = {list_6(CARBINE_MAG),
                       list_4(PISTOL_MAG),
                       GRENADE,
                       list_2(SMOKE_GRENADE)};
        linkedItems[] = {BASE_ITEMS,"ACE_Vector"};
        backpacks[] = {"RHS_M2_MiniTripod_Bag"};
        scopes[] = {};
        attachements[] = {};
    };

    // VEHICLES
    class v_car {
        cargoMagazines[] = {list_8(RIFLE_MAG),
                                list_3(RIFLE_MAG_TR),
                                list_8(RIFLE_MAG),
                                list_3(RIFLE_MAG_TR),
                                list_8(CARBINE_MAG),
                                list_3(CARBINE_MAG_TR),
                                list_5(AR_MAG),
                                list_1(AT_MAG),
                                list_4(SMOKE_GRENADE),
                                list_3(GRENADE),
                                list_1(GLRIFLE_MAG_HE)};
        cargoItems[] = {list_12("ACE_fieldDressing"),list_4("ACE_morphine")};
        cargoBackpacks[] = {};
        cargoWeapons[] = {};
    };
    class v_tr {
        cargoMagazines[] = {list_12(RIFLE_MAG),
                                list_5(RIFLE_MAG_TR),
                                list_12(RIFLE_MAG),
                                list_5(RIFLE_MAG_TR),
                                list_8(CARBINE_MAG),
                                list_3(CARBINE_MAG_TR),
                                list_10(AR_MAG),
                                list_4(AT_MAG),
                                list_8(SMOKE_GRENADE),
                                list_4(GRENADE),
                                list_3(GLRIFLE_MAG_HE)};
        cargoItems[] = {list_25("ACE_fieldDressing"),list_10("ACE_morphine")};
        cargoBackpacks[] = {};
        cargoWeapons[] = {};
    };
    class v_ifv {
        cargoMagazines[] = {list_8(RIFLE_MAG),
                                list_3(RIFLE_MAG_TR),
                                list_8(RIFLE_MAG),
                                list_3(RIFLE_MAG_TR),
                                list_8(CARBINE_MAG),
                                list_3(CARBINE_MAG_TR),
                                list_5(AR_MAG),
                                list_1(AT_MAG),
                                list_4(SMOKE_GRENADE),
                                list_3(GRENADE),
                                list_1(GLRIFLE_MAG_HE)};
        cargoItems[] = {list_12("ACE_fieldDressing"),list_4("ACE_morphine")};
        cargoBackpacks[] = {};
        cargoWeapons[] = {};
    };
    class crate_small {
        cargoMagazines[] = {list_8(RIFLE_MAG),
                        list_3(RIFLE_MAG_TR),
                        list_8(RIFLE_MAG),
                        list_3(RIFLE_MAG_TR),
                        list_8(CARBINE_MAG),
                        list_3(CARBINE_MAG_TR),
                        list_5(AR_MAG),
                        list_1(AT_MAG),
                        list_4(SMOKE_GRENADE),
                        list_3(GRENADE),
                        list_1(GLRIFLE_MAG_HE)};
        cargoItems[] = {list_12("ACE_fieldDressing"),list_4("ACE_morphine")};
        cargoBackpacks[] = {};
        cargoWeapons[] = {};
    };
    class crate_med {
        cargoMagazines[] = {list_8(RIFLE_MAG),
                        list_3(RIFLE_MAG_TR),
                        list_8(RIFLE_MAG),
                        list_3(RIFLE_MAG_TR),
                        list_8(CARBINE_MAG),
                        list_3(CARBINE_MAG_TR),
                        list_5(AR_MAG),
                        list_1(AT_MAG),
                        list_4(SMOKE_GRENADE),
                        list_3(GRENADE),
                        list_1(GLRIFLE_MAG_HE)};
        cargoItems[] = {list_12("ACE_fieldDressing"),list_4("ACE_morphine")};
        cargoBackpacks[] = {};
        cargoWeapons[] = {};
    };
    
    
};