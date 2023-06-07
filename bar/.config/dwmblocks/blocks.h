//Modify this file to change what commands output to your statusbar, and recompile using the make command.
#define PATH(name)
static Block blocks[] = {
	/*Icon*/	/*Command*/		/*Update Interval*/	/*Update Signal*/
<<<<<<< HEAD
<<<<<<< HEAD
  {"", "", 60, 0},
	{" ", "free -h | awk '/^Mem/ { print $3\"/\"$2 }' | sed s/i//g",	30,		0},
  {" ", "cat /sys/class/power_supply/BAT1/capacity", 60, 0},
=======
  {" ", "", 60, 0},
	{" ", "free -h | awk '/^Mem/ { print $3\"/\"$2 }' | sed s/i//g",	30,		0},
  {" ", "cat /sys/class/power_supply/BAT0/capacity", 60, 0},
>>>>>>> 8e91809 (First Commit)
	{"", " date  '+ %I:%M %p'", 					10,		0},
	{"墳 ", "pamixer --get-volume", 					1, 		0},
=======
>>>>>>> b3f07e6 (Improved the nvim autocomplete config by: 1) Fixing overlapping keybinds 2) Adding the buffer and path as possible autocomplete sources)

  {"^B4^  ", "bar_screenshot.sh", 60, 11},
  {"^B4^  ", "void.sh", 60, 1},
	{"^B4^ ", "ram_usage.sh",	30,		2},
  {"^B4^ ", "battery.sh", 60, 3},
	{"", "audio.sh", 					1, 		7},
	{"^B4 ^  ", "timedate.sh", 					10,		4},
};

//sets delimeter between status commands. NULL character ('\0') means no delimeter.
static char delim[] = "^B0^  ";
static unsigned int delimLen = 5 ;

