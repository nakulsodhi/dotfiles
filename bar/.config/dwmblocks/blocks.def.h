//Modify this file to change what commands output to your statusbar, and recompile using the make command.
static const Block blocks[] = {
	/*Icon*/	/*Command*/		/*Update Interval*/	/*Update Signal*/
  {" ", "", 60, 0},
	{" ", "free -h | awk '/^Mem/ { print $3\"/\"$2 }' | sed s/i//g",	30,		0},
<<<<<<< HEAD
  {" ", "cat /sys/class/power_supply/BAT1/capacity", 60, 0},
=======
  {" ", "cat /sys/class/power_supply/BAT0/capacity", 60, 0},
>>>>>>> 8e91809 (First Commit)
	{"", " date  '+ %I:%M %p'", 					10,		0},
	{"墳 ", "pamixer --get-volume", 					1, 		0},

	{"", "date '+%b %d (%a)'",					5,		0},
};

//sets delimeter between status commands. NULL character ('\0') means no delimeter.
static char delim[] = "  ";
static unsigned int delimLen = 5 ;

