#A UI for launching various couch-multiplayer games from within i3

#Copyright (C) 2016 Michael Ruigrok - protected under Australian and International Copyright law
#Michael Ruigrok can be found at http://www.github.com/michaelruigrok/
#or at ruigrok.michael@gmail.com 
#Licence found within licence.txt 
############################################ 
  
#!/bin/bash

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
	$1 & (sleep 1 && i3-msg 'fullscreen toggle');
	wait $!
	sleep 1.5
	i3-msg 'workspace 1';
	clear
	printf "\033c"
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

while true; do
	echo "I don't even know what I'm doing, lol"
	echo "Here are all the games we have on offer:

	Multiplayer - 4 player:

	[1] Screencheat		 - a splitscreen FPS where everyone's invisble, so you have to 'screencheat' to find other players
	[2] TowerFall		 - An insanely paced 2D archery battle royale. Think smash bros, but with muliple insta-kill rounds
	[3] Super Smash Bros	 - A 2.5D brawler battle royale. Think TowerFall, but instead you're beating up Nintendo characters
	[4] Star Fox 64		 - Locally known as Lylat Wars, pilot an X-Wing-esque ship and shoot your opponents out of the sky
	[5] Mario Party 	 - Oh you want a party, eh? I'll show you a party!
	[6] Mario Party 3 	 - Oh you want a par- oh, I've already done this bit. Move along...
	[7] GoldenEye 007	 - The original splitscreen shooter. No screencheating in this one, mmmkay?
	[8] Mario Tennis 64	 - Well you see, there's this green ball that 2-4 players hit with these snow-shoe things...
	[9] F-Zero X		 - Race futuristic rocket-cars at the speed of very-very-fast

	There's also the 4-player co-op games 1001 Spikes and Mercenary Kings on Steam, but you'll have to talk to Michael about that.

	2 player:
	[10] Lovers in a Dangerous Spacetime - A co-op space adventure where you must work with your teammate to pilot a ship and save bunnies
	[11] Street Fighter III/Alpha 3 - to play one of these, select game and type /play into the console. It's a bit fiddley.
	
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
		   	sudo screencheat
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
			fullscreen_exec 'mupen64plus /usr/local/games/roms/n64/Super-Smash-Bros.z64'
		   	continue;;
        4 ) 
			fullscreen_exec 'mupen64plus /usr/local/games/roms/n64/Star-Fox.z64'
		   	continue;;
        5 ) 
			fullscreen_exec 'mupen64plus /usr/local/games/roms/n64/Mario-Party.z64'
		   	continue;;
        6 ) 
			fullscreen_exec 'mupen64plus /usr/local/games/roms/n64/Mario-Party-3.n64'
		   	continue;;
        7 ) 
			fullscreen_exec 'mupen64plus /usr/local/games/roms/n64/GoldenEye.z64'
		   	continue;;
        8 ) 
			fullscreen_exec 'mupen64plus /usr/local/games/roms/n64/Mario-Tennis.z64'
			continue;;
        9 ) 
			fullscreen_exec 'mupen64plus /usr/local/games/roms/n64/F-Zero-X.z64'
		   	continue;;
        10 ) 
			floating_exec 'liads'
		   	continue;;
        11 ) 
			fullscreen_exec 'fightcade;'
		   	continue;;
        * ) echo "Please answer yes or no.";;
    esac
	clear
	printf "\033c"
done

