#!/usr/bin/awk -f
#
# This program was a nice test of code, to extract songs from a CD with only
# cd-paranoia and cd-info. 
# Unfortunately, I attempted to re-use the group matches in awk as $2 etc.,
# which is unsupported. Awk prefers fields instead. Oh well.


BEGIN {
	ripmode = "none";
	system("mkdir -p /tmp/cd/");
	FS = "[ \t]*:[ \t]*";
}

/^CD-TEXT for Disc:$/ {
	ripmode = "Disk";
}

/^CD-TEXT for Track\s*(\d*)/ {
	ripmode = "Track";
	trackNum = $2;
}

/PERFORMER: (.*)$/ {
	performer = $2;
	if (ripmode != "Disk") {
		system("mkdir -p /tmp/cd/"performer"/"discName);
	}
}

/^[ \t]*ISRC:/ {
	print ripmode;
	if (ripmode != "Track") {
		print "Error! Not in the correct mode to rip song.";
		print "ripmode was "ripmode;
		print "I probably shouldn't be ripping the song on the ISRC line, but" \
		" whatever.";
		exit 127;
	}

	command = "cdparanoia -w "trackNum" /tmp/cd/"trackNum" - "discName;
	print "ready to execute" command;
	#system(command);
}

/TITLE: (.*)$/ {
	switch (ripmode) {
		case "Disk":
			discName = $2;
			break;
		case "Track":
			trackName = $2;
			break;
		default:
			print "Error! Failed to guess correct output state.";
			exit 127;
	}
}

END {
	print "DONE!";
}
