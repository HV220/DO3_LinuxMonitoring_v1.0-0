#!/bin/bash

source ../libs/colors_bash.sh
source ./part4.conf
source ../03/part3.sh

PR_1=6
PR_2=1
PR_3=2
PR_4=4

function check_color() {
    if [ "$1" = "1" ]
    then
    echo "white"
    elif [ "$1" = "2" ]
    then
    echo "red"
    elif [ "$1" = "3" ]
    then
    echo "green"
    elif [ "$1" = "4" ]
    then
    echo "blue"
    elif [ "$1" = "5" ]
    then
    echo "purple"
    elif [ "$1" = "6" ]
    then
    echo "black"
    fi
}
function print_colors() {

for (( j=1; j <= 6; j++ ))
do
if [[ $1 = $j ]]
then
color_1=$(check_color $1)
fi

if [[ $2 = $j ]]
then
color_2=$(check_color $2)
fi

if [[ $3 = $j ]]
then
color_3=$(check_color $3)
fi

if [[ $4 = $j ]]
then
color_4=$(check_color $4)
fi

done

if [ "$5" = "default" ]
then
echo -en "
Column 1 background = default $color_1
Column 1 font color = default $color_2
Column 2 background = default $color_3
Column 2 font color = default $color_4
"
else
echo -en "
Column 1 background = $1 $color_1
Column 1 font color = $2 $color_2
Column 2 background = $3 $color_3
Column 2 font color = $4 $color_4
"
fi
}

function part_4() {
re='[1-6]'
if [[ $column1_background =~ $re ]] && [[ $column1_font_color =~ $re ]] && [[ $column2_font_color =~ $re ]] && [[ $column2_background =~ $re ]]
then
check_parametrs ${column1_background} ${column1_font_color} ${column2_background} ${column2_font_color}
part_3
print_colors ${column1_background} ${column1_font_color} ${column2_background} ${column2_font_color}
else
check_parametrs ${PR_1} ${PR_2} ${PR_3} ${PR_4}
part_3
print_colors ${PR_1} ${PR_2} ${PR_3} ${PR_4} "default"
fi
}
