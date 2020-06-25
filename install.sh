#!/bin/bash
do_remove() {
printf "\e[5;1;4;31mWARNING: 'config.fish' WILL BE REMOVED\e\n"
printf "\e[5;1;4;31mPRESS CTRL+C TO CANCEL\e\n"
printf "\e[5;1;4;31mWILL CONTINUE AFTER 5"
echo -e "\e[5;1;4;31m....." | pv -qL 2 & sleep 8
rm "$HOME/.config/fish/functions/fish_prompt.fish"
rm "$HOME/.config/fish/config.fish"
echo "SquidPrompt Has Been Removed"
exit 0
}

./Xdialog --rc-file --wmname KWin --backtitle "TGW ~ ThatGeekyWeeb ~ ZsRR" --title "Choice Box!" \
        --checklist "Hi, this is a checklist box. You can use this to\n\
present a list of choices which can be turned on or\n\
off. If there are more items than can fit on the\n\
screen, the list will be scrolled.\n\n\
Which of the following are fruits?" 30 70 4 \
        "Battery"    "Non-Posix 3rd Party Item" off \
        "TimeType"   "'Time='Now'" off \
        "None"       "Basic Install" off \
        "Uninstall"  "REMOVE SQUID-PROMPT" off 2> /tmp/checklist.tmp.$$
case $? in
    	1)
        	exit 1;;
        255)
            	exit 1;;
esac
        	

timetype1() {
	touch -a "$HOME/.config/fish/config.fish"
	echo 'export timetype="true"' >> "$HOME/.config/fish/config.fish"
}

battery1() {
        touch -a "$HOME/.config/fish/config.fish"
        echo 'export bat="true"' >> "$HOME/.config/fish/config.fish"
        curl -O "https://raw.githubusercontent.com/holman/spark/master/spark"
       	sudo mv spark "/usr/local/bin"
        sudo chmod u+x "/usr/local/bin/spark"
	curl -O "https://raw.githubusercontent.com/goles/battery/master/battery"
	sudo mv battery "/usr/local/bin"
	sudo chmod u+x "/usr/local/bin/battery"
}


retval=$?

choice=`cat /tmp/checklist.tmp.$$`
case $retval in
  1)
    echo "Cancel pressed."
    exit 1;;
  255)
    echo "Box closed."
    exit 1;;
esac
var1=$(echo "$choice")
choice=""
if [ "$var1" = "Uninstall" ]; then
    do_remove
    exit 0
fi
case $? in
    	0)
        	./Xdialog --title "Installing Battery" --yesno "Installing 'Battery'
		Will require 'sudo'" 30 30
		case $? in
    			0)
        			echo "sudo allowed"
				echo "installing 'Battery'";;
        		1)
            			var1=$(echo "$var1" | cut -d/ -f2);;
        		255)
            			exit 1;;
		esac
		;;
	1)
    	exit 1;;
esac
do_install() {
    install -Dm 644 ./SquidPrompt.fish "$HOME/.config/fish/functions/fish_prompt.fish"
}
do_install
case "$var1" in
    	Battery)
        	battery1
            	exit 0;;
        TimeType)
            	timetype1
            	exit 0;;
	Battery/TimeType)
    		battery1
    		timetype1
    		exit 0;;
esac
