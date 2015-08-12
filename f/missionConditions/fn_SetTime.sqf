// F3 - SetTime
// Credits: Please see the F3 online manual (http://www.ferstaberinde.com/f3/en/)
// ====================================================================================

private ["_hour","_minute"];

// ====================================================================================

// SET KEY VARIABLES
// We interpret the values parsed to the script. If the function was called from the parameters those values are used.

params["_timeOfDay"];

// ====================================================================================

// SET DEFAULT VALUES
// The default values that together form the in-game date are set.

date params ["_year","_month","_day"];
_hour = 0;
_minute = 0;

// ====================================================================================

// SELECT MISSION TIME OF DAY
// Using the value of _timeOfDay, we define new values for _hour and _minute.

switch (_timeOfDay) do
{
// Dawn
	case 0:
	{
		_hour = 4;
		_minute = 50;
	};
// Early Morning
	case 1:
	{
		_hour = 5;
		_minute = 20;
	};
// Morning
	case 2:
	{
		_hour = 9;
		_minute = 20;
	};
// Noon
	case 3:
	{
		_hour = 12;
		_minute = 00;
	};
// Afternoon
	case 4:
	{
		_hour = 15;
		_minute = 30;
	};
// Evening
	case 5:
	{
		_hour = 18;
		_minute = 40;
	};
// Dusk
	case 6:
	{
		_hour = 19;
		_minute = 10;
	};
// Night
	case 7:
	{
		_hour = 0;
		_minute = 0;
	};
};

// ====================================================================================

// SET DATE VARIABLE
// Using the single variables, we construct a new variable _date
_date = [_year,_month,_day,_hour,_minute];

// ====================================================================================

// SET DATE 

setDate _date;

// ====================================================================================
