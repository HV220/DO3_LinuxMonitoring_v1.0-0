#!/bin/bash
source ./libs/colors_bash.sh

PARAMETR_1=${NORMAL}
PARAMETR_2=${NORMAL}
PARAMETR_3=${NORMAL}
PARAMETR_4=${NORMAL}

function error_1_3() {
echo "1ый и 3ий параметры совпадают, пожалуйста перезапустите скрипт с новыми параметрами"
exit
}

function error_2_4() {
echo "2ый и 4ий параметры совпадают, пожалуйста перезапустите скрипт с новыми параметрами"
exit
}

function check_color_param_2_4() {
if [ "$1" = "1" ]
then
echo $NORMAL
fi

if [ "$1" = "2" ]
then
echo $RED
fi

if [ "$1" = "3" ]
then
echo $GREEN
fi

if [ "$1" = "4" ]
then
echo $BLUE
fi

if [ "$1" = "5" ]
then
echo $MAGENTA
fi

if [ "$1" = "6" ]
then
echo $BLACK
fi
}

function check_color_param_1_3() {
if [ "$1" = "1" ]
then
echo $BGGRAY
fi

if [ "$1" = "2" ]
then
echo $BGRED
fi

if [ "$1" = "3" ]
then
echo $BGGREEN
fi

if [ "$1" = "4" ]
then
echo $BGBLUE
fi

if [ "$1" = "5" ]
then
echo $BGMAGENTA
fi

if [ "$1" = "6" ]
then
echo $BGBLACK
fi
}

function check_parametrs() {

re='[1-6]'

if [[ $1 =~ $re ]]
then

if [[ $1 = $3 ]]
then
error_1_3
else
PARAMETR_1=$(check_color_param_1_3 $1)
fi

fi

if [[ $2 =~ $re ]]
then

if [[ $2 = $4 ]]
then
error_2_4
else
PARAMETR_2=$(check_color_param_2_4 $2)
fi

fi

if [[ $3 =~ $re ]]
then
PARAMETR_3=$(check_color_param_1_3 $3)
fi

if [[ $4 =~ $re ]]
then
PARAMETR_4=$(check_color_param_2_4 $4)
fi
}

function part_2() {
#сетевое имя
HOSTNAME=$(hostnamectl | awk '{print $3;} ' | head -1)
echo -e "${PARAMETR_1}${PARAMETR_2}HOSTNAME${NORMAL} = ${PARAMETR_3}${PARAMETR_4}$HOSTNAME${NORMAL}"

#временная зона в виде: America/New_York UTC -5
type_zone=$(timedatectl | awk '{print $3}' | awk '(NR ==4)')
time_zone=$(timedatectl | awk '{print $6}' | awk '(NR==2)')
difference_time_zone=$(timedatectl | awk '{print $5}' | awk '(NR==4)' | cut -b -2)
echo -e "${PARAMETR_1}${PARAMETR_2}TIMEZONE${NORMAL} = ${PARAMETR_3}${PARAMETR_4}$type_zone $time_zone $difference_time_zone${NORMAL}"

#текущий пользователь который запустил скрипт
USER=$(users)
echo -e "${PARAMETR_1}${PARAMETR_2}USER${NORMAL} = ${PARAMETR_3}${PARAMETR_4}$USER${NORMAL}"

#тип и версия операционной системы
type_OS=$(hostnamectl | awk '{print $3}' | awk '(NR==6)')
version_OS=$(hostnamectl | awk '{print $3}' | awk '(NR==7)')
echo -e "${PARAMETR_1}${PARAMETR_2}OS${NORMAL} = ${PARAMETR_3}${PARAMETR_4}$type_OS $version_OS${NORMAL}"

#текущее время в виде: 12 May 2020 12:24:36
DATE=$(date "+%d %B %Y %T")
echo -e "${PARAMETR_1}${PARAMETR_2}DATE${NORMAL} = ${PARAMETR_3}${PARAMETR_4}$DATE${NORMAL}"

#время работы системы
UPTIME=$(uptime -p)
echo -e "${PARAMETR_1}${PARAMETR_2}UPTIME${NORMAL} = ${PARAMETR_3}${PARAMETR_4}$UPTIME${NORMAL}"

#время работы системы в секундах
UPTIME_SECOND=$(awk '{print $1}' /proc/uptime)
echo -e "${PARAMETR_1}${PARAMETR_2}UPTIME_SECOND${NORMAL} = ${PARAMETR_3}${PARAMETR_4}$UPTIME_SECOND seconds${NORMAL}"

#ip-адрес машины в любом из сетевых интерфейсов
IP=$(ip a | awk '{print $2}' | awk '(NR==3)')
echo -e "${PARAMETR_1}${PARAMETR_2}IP${NORMAL} = ${PARAMETR_3}${PARAMETR_4}$IP${NORMAL}"

#сетевая маска любого из сетевых интерфейсов в виде: xxx.xxx.xxx.xxx
MASK=$(ip a | awk '{print $2}' | awk '(NR==2)')
echo -e "${PARAMETR_1}${PARAMETR_2}MASK${NORMAL} = ${PARAMETR_3}${PARAMETR_4}$MASK${NORMAL}"

#ip шлюза по умолчанию
GATEWAY=$(ip route | awk '{print $3}' | awk '(NR==1)')
echo -e "${PARAMETR_1}${PARAMETR_2}GATEWAY${NORMAL} = ${PARAMETR_3}${PARAMETR_4}$GATEWAY${NORMAL}"

#размер оперативной памяти в Гб c точностью три знака после запятой в виде: 3.125 GB
RAM_TOTAL=$(awk '{print $2}' /proc/meminfo | awk '(NR==1)' | awk '{printf "%.3f",$1/1024/1024}')
echo -e "${PARAMETR_1}${PARAMETR_2}RAM_TOTAL${NORMAL} = ${PARAMETR_3}${PARAMETR_4}$RAM_TOTAL GB${NORMAL}"
RAM_USED=$(free | awk '{print $3}' | awk '(NR==2)' | awk '{printf "%.3f", $1/1024/1024}')
echo -e "${PARAMETR_1}${PARAMETR_2}RAM_USED${NORMAL} = ${PARAMETR_3}${PARAMETR_4}$RAM_USED GB${NORMAL}"
RAM_FREE=$(free | awk '{print $4}' | awk '(NR==2)' | awk '{printf "%.3f", $1/1024/1024}')
echo -e "${PARAMETR_1}${PARAMETR_2}RAM_FREE${NORMAL}  = ${PARAMETR_3}${PARAMETR_4}$RAM_FREE GB${NORMAL}"

# размер рутового раздела в Mб с точностью два знака после запятой в виде: 254.25 MB
SPACE_ROOT=$(df -i / | awk '{print $2}' | awk '(NR==2)' | awk '{printf "%.2f", $1/1024}')
SPACE_ROOT_FREE=$(df -i / | awk '{print $4}' | awk '(NR==2)' | awk '{printf "%.2f", $1/1024}')
SPACE_ROOT_USED=$(df -i / | awk '{print $3}' | awk '(NR==2)' | awk '{printf "%.2f", $1/1024}')
echo -e "${PARAMETR_1}${PARAMETR_2}SPACE_ROOT${NORMAL} = ${PARAMETR_3}${PARAMETR_4}$SPACE_ROOT MB${NORMAL}"
echo -e "${PARAMETR_1}${PARAMETR_2}SPACE_ROOT_USED${NORMAL} = ${PARAMETR_3}${PARAMETR_4}$SPACE_ROOT_USED MB${NORMAL}"
echo -e "${PARAMETR_1}${PARAMETR_2}SPACE_ROOT_FREE${NORMAL} = ${PARAMETR_3}${PARAMETR_4}$SPACE_ROOT_FREE MB${NORMAL}"
}

function main() {
check_parametrs $1 $2 $3 $4
part_2
}
main $1 $2 $3 $4