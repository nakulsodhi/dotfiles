//Modify this file to change what commands output to your statusbar, and recompile using the make command.
#define PATH(name)
static Block blocks[] = {
	/*Icon*/	/*Command*/		/*Update Interval*/	/*Update Signal*/
  {"^B4^  ", "void.sh", 60, 1},
	{"^B4^ ", "ram_usage.sh",	30,		2},
  {"^B4^ ", "battery.sh", 60, 3},
	{"", "audio.sh", 					1, 		7},
	{"^B4 ^  ", "timedate.sh", 					10,		4},
};

//sets delimeter between status commands. NULL character ('\0') means no delimeter.
static char delim[] = "^B0^  ";
static unsigned int delimLen = 5 ;

