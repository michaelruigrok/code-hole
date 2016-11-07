#!/bin/bash

#A UI for launching various couch-multiplayer games from within i3

#Copyright (C) 2016 Michael Ruigrok - protected under Australian and International Copyright law
#Michael Ruigrok can be found at http://www.github.com/michaelruigrok/
#or at ruigrok.michael@gmail.com 
#Licence found within licence.txt 
############################################ 
  

function game_exec {
	i3-msg 'workspace 3';
	$1;
	wait $!
	sleep 1.5
	i3-msg 'workspace 1';
	clear
	printf "\033c"
}

function fullscreen_exec {
	i3-msg 'workspace 3';
	$1 & (sleep 5 && i3-msg 'fullscreen toggle');
	wait $!
	sleep 1.5
	i3-msg 'workspace 1';
	clear
	printf "\033c"
}

function sudo_exec {
	i3-msg 'workspace 3;'
	if [ $USER == "games" ]
	then 
		sudo $1 & (sleep 1 && i3-msg 'fullscreen toggle');
	else
		$1 & (sleep 1 && i3-msg 'fullscreen toggle');
	fi
	wait $!
	sleep 1.5
	i3-msg 'workspace 1';
	clear
	printf "\033c"
	echo $(whoami)
	echo $USER
}

function floating_exec {
	i3-msg 'workspace 3';
	$1 & (sleep 4 && i3-msg 'floating toggle; fullscreen toggle');
	wait $!
	sleep 1.5
	i3-msg 'workspace 1';
	clear
	printf "\033c"
}

sed -i "s/^FontName.*/FontName=DejaVu Sans Mono 11/" ~/.config/xfce4/terminal/terminalrc 
SCREEN=$(xrandr -q | grep ' connected ' | wc -l)
SCREEN="${SCREEN}"
if [ $SCREEN -gt 1 ] 
then
	xrandr --output eDP1 --off 2> /dev/null
	xrandr --output $SCREEN --auto 2> /dev/null
	sed -i "s/^FontName.*/FontName=DejaVu Sans Mono 14/" ~/.config/xfce4/terminal/terminalrc 
fi

GAMES=/usr/local/games/
ROMS=/usr/local/games/roms/


while true; do
	echo "I don't even know what I'm doing, lol"
	echo -e "Here are all the games we have on offer:

	 \e[1;31mMultiplayer - 4 player:\e[0m

	\e[1;35m[1] Screencheat		 - a splitscreen FPS where everyone's invisble, so you have to 'screencheat' to find other players\e[0m
	\e[1;34m[2] TowerFall		 - An insanely paced 2D archery battle royale. Think smash bros, but with muliple insta-kill rounds
					Note: On close, this game might seem to crash. When this happens, press ctrl + shift + f2, and then
					ctrl + shift + f1. If it's still weird, press windows + random number, and then Win + the numbers on
					The bottom left hand corner of the screen. If it's still screwed, just press the power button and reboot\e[0m
	\e[1;38m[3] Super Smash Bros	 - A 2.5D brawler battle royale. Think TowerFall, but instead you're beating up Nintendo characters\e[0m
	\e[1;32m[4] Star Fox 64		 - Locally known as Lylat Wars, pilot an X-Wing-esque ship and shoot your opponents out of the sky\e[0m
	\e[1;34m[5] Mario Party 	 - Oh you want a party, eh? I'll show you a party!\e[0m
	\e[1;95m[6] Mario Party 3 	 - Oh you want a par- oh, I've already done this bit. Move along...\e[0m
	\e[1;31m[7] GoldenEye 007	 - The original splitscreen shooter. No screencheating in this one, mmmkay?\e[0m
	\e[1;93m[8] Mario Tennis 64	 - Well you see, there's this green ball that 2-4 players hit with these snow-shoe things...\e[0m
	\e[1;36m[9] F-Zero X		 - Race futuristic rocket-cars at the speed of very-very-fast\e[0m
	\e[1;34m[10] *Shrek Super Slam	- A 3d brawler thing, with Shrek and friends. Pretty dank.
	\e[1;95m[11] Smash Bros. Melee	- A 2d brawler thing, with Mario and friends. Pretty dank.
	\e[1;31m[12] TimeSplitters: FP	- An splitscreen FPS. Don't know much about it. Do you split time? You'll have to find out

	There's also 1001 Spikes, Nidhogg, Skullgirls and Mercenary Kings on Steam, but you'll have to talk to Michael about that.

	2 player:
	\e[1;31m[15] Lovers in a Dangerous Spacetime - A co-op space adventure where you must work with your teammate to pilot a ship and save bunnies\e[0m
				Note: You'll have to change the resolution settings in the menu to make it properly fullscreen, if using TV
	\e[1;34m[16] Street Fighter III/Alpha 3 - to play one of these, select game and type /play into the console. It's a bit fiddley.\e[0m
	\e[1;32m[17] Street Fighter III/ II hyper edition - PS2 version, possibly less fiddley, but no sound.-

	Note: You can shut down a game by pressing Windows + Shift + Q, which is pretty necessary for
	Any of the emulators
	
	Settings:
	\e[1;33m[20] Edit volume\e[0m
	\e[1;92m[21] Connect to TV (via HDMI, VGA, etc)\e[0m
	\e[1;94m[22] Disconnect from TV\e[0m
	"

    read -p "Select the number corresponding to the game to play!: " game
    case $game in
        1 ) 
			echo "Great! There's some weird controller things we have to set up for you."
			echo "Make sure all your controllers are plugged in before continuing."
			echo "How many controllers are you using?"
			read CONTS
			let CONTS-=1
			until [ $CONTS -lt 0 ]; do
				echo "$CONTS"one
				echo $CONTS tow
				COMAND="controller_setup "$CONTS""
				echo ""$COMAND""
				echo "done"
				i3-msg "workspace 2; exec --no-startup-id xterm -e "$COMAND"";
				sleep 0.1
				i3-msg "workspace 1;"
				let CONTS-=1
			done
			i3-msg 'workspace 3;'
			if [ whoami -eq "games" ]
			then 
				sudo screencheat
			else
				screencheat
			fi
			wait $!
			i3-msg 'workspace 1;'
			clear
			printf "\033c"
			killall controller_setup
			continue;;
        2 ) 
			game_exec 'towerfall'
		   	continue;;
        3 ) 
			fullscreen_exec "mupen64plus $ROMS/n64/Super-Smash-Bros.z64"
		   	continue;;
        4 ) 
			fullscreen_exec "mupen64plus $ROMS/n64/Star-Fox.z64"
		   	continue;;
        5 ) 
			fullscreen_exec "mupen64plus $ROMS/n64/Mario-Party.z64"
		   	continue;;
        6 ) 
			fullscreen_exec "mupen64plus $ROMS/n64/Mario-Party-3.n64"
		   	continue;;
        7 ) 
			fullscreen_exec "mupen64plus $ROMS/n64/GoldenEye.z64"
		   	continue;;
        8 ) 
			fullscreen_exec "mupen64plus $ROMS/n64/Mario-Tennis.z64"
			continue;;
        9 ) 
			fullscreen_exec "mupen64plus $ROMS/n64/F-Zero-X.z64"
		   	continue;;
		10 )
			sudo_exec "PCSX2 $ROMS/ps2/Shrek-Super-Slam.iso"
			continue;;
		11 )
			fullscreen_exec "dolphin-emu $ROMS/gc/Super-Smash-Bros-Melee.iso"
			continue;;
		12 )
			fullscreen_exec "dolphin-emu $ROMS/gc/TimeSplitters-Future_Perfect.iso"
			continue;;
        15 ) 
			floating_exec 'liads'
		   	continue;;
        16 ) 
			fullscreen_exec 'fightcade'
		   	continue;;
		17 )
			sudo_exec "PCSX2 $ROMS/ps2/Street-Fighter-Anniversary1.iso"
			continue;;
		20 )
			game_exec 'pavucontrol'
			continue;;
		21 )
			echo "Make sure the cable is plugged in. If it stuffs up, simply press "N" (and then Enter) to revert immediately."
			read -p "Press enter to continue..."
			SCREEN=$(xrandr -q | grep ' connected ' | tail -n 1 | awk '{ print$1 }')
			SCREEN="${SCREEN}"
			xrandr --output eDP1 --off 2> /dev/null
			xrandr --output $SCREEN --auto 2> /dev/null
			sed -i "s/^FontName.*/FontName=DejaVu Sans Mono 14/" ~/.config/xfce4/terminal/terminalrc 
			#(sleep 5 && 
				#xrandr --output $SCREEN --off &&
				#xrandr --output eDP1 --auto
				#)
			#PID=$!
			read -p "Did the changes work? (Y/N): " game
			case $game in
				[Yy] )
					#kill $PID
					clear
					printf "\033c"
					continue;;
				[Nn] )
					#kill $PID
					xrandr --output $SCREEN --off 2> /dev/null
					xrandr --output eDP1 --auto 2> /dev/null
					xrandr --output $SCREEN --off 2> /dev/null
					xrandr --output eDP1 --auto 2> /dev/null
					sed -i "s/^FontName.*/FontName=DejaVu Sans Mono 12/" ~/.config/xfce4/terminal/terminalrc 
					clear
					printf "\033c"
					continue;;
			esac
			continue;;
		22 )
			sed -i "s/^FontName.*/FontName=DejaVu Sans Mono 11/" ~/.config/xfce4/terminal/terminalrc
			SCREEN=$(xrandr -q| grep ' connected ' | tail -n 1 | awk '{ print$1 }')
			SCREEN="${SCREEN}"
			xrandr --output $SCREEN --off 2> /dev/null
			xrandr --output eDP1 --auto 2> /dev/null
			continue;;

        * ) echo "Please answer yes or no.";;
    esac
	clear
	printf "\033c"
done

