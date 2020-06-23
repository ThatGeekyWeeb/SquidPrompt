#!/bin/sh
./Xdialog --rc-file --wmname KWin --backtitle "TGW ~ ThatGeekyWeeb ~ ZsRR" --title "Choice Box!" \
        --checklist "Hi, this is a checklist box. You can use this to\n\
present a list of choices which can be turned on or\n\
off. If there are more items than can fit on the\n\
screen, the list will be scrolled.\n\n\
Which of the following are fruits?" 30 70 3 \
        "Battery"    "Non-Posix 3rd Party Item" off \
        "TimeType"   "'Time='Now'" off \
        "None"       "Basic Install" off 2> /tmp/checklist.tmp.$$

retval=$?

choice=`cat /tmp/checklist.tmp.$$`
case $retval in
  0)
    echo "$choice chosen.";;
  1)
    echo "Cancel pressed."
    exit 1;;
  255)
    echo "Box closed."
    exit 1;;
esac
var1=$(echo "$choice")
choice=""
echo "$var1"
./Xdialog --title "Config" \
        --msgbox "Hello!
        In the next section select
        Your 'config.fish' location!" 10 41
case $? in
  0)
    echo "OK";;
  255)
    echo "Box closed."
    exit 1;;
esac
FILE=`./Xdialog --title "Please choose a file" --fselect /home 32 60 2>&1`

case $? in
	0)
		var21=$(echo "$FILE");;
	1)
		exit 1;;
	255)
		exit 1;;
esac
var112=$(echo "$var21" | grep "config.fish")
grep1=$(echo "$var1" | grep -q "Battery")
case $? in
    	0)
        	./Xdialog --title "Installing Battery" --yesno "Installing 'Battery'
		Will require 'sudo'" 30 30
		case $? in
    			0)
        			echo "sudo allowed"
				echo "installing 'Battery'"
				curl -O "https://raw.githubusercontent.com/holman/spark/master/spark"
				sudo mv "./spark" "/usr/local/bin";;
        		1)
            			echo "$var1";;
        		255)
            			exit 1;;
		esac
		;;
	1)
    	exit 1;;
esac

./Xdialog --title Prompt Location --msgbox "Select Prompt loaction" 40 40
case $? in
	0)
    		FILE=`./Xdialog --title "Please choose a file" --fselect /home 32 60 2>&1`
		case $? in
			0)
				loc=$(echo "$FILE");;
			1)
				exit 1;;
			255)
				exit 1;;
		esac
		;;
esac
do_install() {
    install -Dm 644 ./SquidPrompt.fish "$loc"
}
do_install
exit 0
