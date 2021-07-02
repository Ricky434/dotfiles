//Modify this file to change what commands output to your statusbar, and recompile using the make command.
static const Block blocks[] = {
	/*Icon*/	/*Command*/		/*Update Interval*/	/*Update Signal*/
	{" ", "uname -r",	360000,		0},

	{"^c#ecbe7b^💻 cpu:", "~/.dwm/scripts/cpu",	1,		0},

	{"^c#ff6c6b^🖥 mem: ", "free --mega | awk '/^Mem/ { print $3\"M\" }' | sed s/i//g",	2,		0},

	{"^c#46d9ff^📅 ", "date '+%b %d (%a) %I:%M%p'",					5,		0},
};

//sets delimeter between status commands. NULL character ('\0') means no delimeter.
static char delim[] = "  ^d^|  ";
static unsigned int delimLen = 7;
