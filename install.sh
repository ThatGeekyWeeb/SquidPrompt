#!/bin/sh
Xdialog --rc-file --wmname KWin --backtitle "TGW ~ ThatGeekyWeeb ~ ZsRR" --title "Choice Box!" \
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
Xdialog --title "Config" \
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
FILE=`Xdialog --title "Please choose a file" --fselect /home 28 48 2>&1`

case $? in
	0)
		var21=$(echo "$FILE");;
	1)
		exit 1;;
	255)
		exit 1;;
esac
var112=$(echo "$var21" | grep "config.fish")
echo "$var112"
