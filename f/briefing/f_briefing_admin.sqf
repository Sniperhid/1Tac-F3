// F3 - Briefing
// Credits: Please see the F3 online manual (http://www.ferstaberinde.com/f3/en/)
// ====================================================================================

// ADD CUSTOM SECTIONS
// Add all messages you want only the admin to be able to see here:

_customText = "";

// ====================================================================================

// ADMIN BRIEFING
// This is a generic section displayed only to the ADMIN

_briefing ="
<br/>
<font size='18'>ADMIN SECTION</font><br/>
This briefing section can only be seen by the current admin.
<br/><br/>
";

// ====================================================================================

// MISSION-MAKER NOTES
// This section displays notes made by the mission-maker for the ADMIN

_briefing ="
<br/>
<font size='18'>MISSION-MAKER NOTES</font><br/>
Notes and messages made by the mission-maker.
";

_briefing = _briefing + _customText;
_briefing = _briefing + "<br/><br/>";

// ====================================================================================

// ENDINGS
// This block of code collects all valid endings and formats them properly

_title = [];
_endings = [];

_i = 1;
while {true} do {
	_title = getText (missionconfigfile >> "CfgDebriefing" >> format ["end%1",_i] >> "title");
	_description = getText (missionconfigfile >> "CfgDebriefing" >> format ["end%1",_i] >> "description");
	if (_title == "") exitWith {};
	_endings pushBack [_i,_title,_description];
	_i = _i + 1;
};


// Create the briefing section to display the endings

_briefing = _briefing + "
ENDINGS<br/>
These endings are available. To trigger an ending click on its link.<br/><br/>
";

{
	_end = _this select 0;
	_briefing = _briefing + format [
	"<execute expression=""[[%1],'f_fnc_mpEnd',false] spawn BIS_fnc_MP;"">'end%1'</execute> - %2:<br/>
	%3<br/><br/>"
	,_x select 0,_x select 1,_x select 2];
} forEach _endings;

// ====================================================================================

// CREATE DIARY ENTRY

player createDiaryRecord ["diary", ["Admin",_briefing]];

// ====================================================================================