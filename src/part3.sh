#!/bin/bash

# Обозначения цветов: (1 - white, 2 - red, 3 - green, 4 - blue, 5 – purple, 6 - black)  
# **Параметр 1** - это фон названий значений (HOSTNAME, TIMEZONE, USER и т.д.)  
# **Параметр 2** - это цвет шрифта названий значений (HOSTNAME, TIMEZONE, USER и т.д.)  
# **Параметр 3** - это фон значений (после знака '=')  
# **Параметр 4** - это цвет шрифта значений (после знака '=')
PARAMETR_1='\033[0m'
PARAMETR_2='\033[0m'
PARAMETR_3='\033[0m'
PARAMETR_4='\033[0m'
DEFAULT_COLOR='\033[0m'

function check_color_param_2() {
if [ "$1" = "1" ]
then
echo '\e[1m'
fi

if [ "$1" = "2" ]
then
echo '\e[31m'
fi

if [ "$1" = "3" ]
then
echo '\e[32m'
fi

if [ "$1" = "4" ]
then
echo '\e[34m'
fi

if [ "$1" = "5" ]
then
echo '\e[0;35m'
fi

if [ "$1" = "6" ]
then
echo '\e[0;30m'
fi
}

function check_color_param_1() {
if [ "$1" = "1" ]
then
echo '\e[7;1m'
fi

if [ "$1" = "2" ]
then
echo '\e[7;31m'
fi

if [ "$1" = "3" ]
then
echo '\e[7;32m'
fi

if [ "$1" = "4" ]
then
echo '\e[7;34m'
fi

if [ "$1" = "5" ]
then
echo '\e[7;35m'
fi

if [ "$1" = "6" ]
then
echo '\e[7;30m'
fi
}

function check_parametrs() {

re='[1-6]'

if [[ $1 =~ $re ]]
then
PARAMETR_1=$(check_color_param_1 $1)
fi

if [[ $2 =~ $re ]]
then
PARAMETR_2=$(check_color_param_2 $2)
fi

if [[ $3 =~ $re ]]
then
PARAMETR_3=$(check_color_param_2 $3)
fi

if [[ $4 =~ $re ]]
then
PARAMETR_4=$(check_color_param_2 $4)
fi
}

function part_2() {
#сетевое имя
HOSTNAME=$(hostnamectl | awk '{print $3;} ' | head -1)
echo -e "${PARAMETR_1}${PARAMETR_2}HOSTNAME${DEFAULT_COLOR} = $HOSTNAME"

#временная зона в виде: America/New_York UTC -5
type_zone=$(timedatectl | awk '{print $3}' | awk '(NR ==4)')
time_zone=$(timedatectl | awk '{print $6}' | awk '(NR==2)')
difference_time_zone=$(timedatectl | awk '{print $5}' | awk '(NR==4)' | cut -b -2)
echo -e "${PARAMETR_1}TIMEZONE${DEFAULT_COLOR} = $type_zone $time_zone $difference_time_zone"

#текущий пользователь который запустил скрипт
USER=$(users)
echo -e "${PARAMETR_1}USER${DEFAULT_COLOR} = $USER"

#тип и версия операционной системы
type_OS=$(hostnamectl | awk '{print $3}' | awk '(NR==6)')
version_OS=$(hostnamectl | awk '{print $3}' | awk '(NR==7)')
echo -e "${PARAMETR_1}OS${DEFAULT_COLOR} = $type_OS $version_OS"

#текущее время в виде: 12 May 2020 12:24:36
DATE=$(date "+%d %B %Y %T")
echo -e "${PARAMETR_1}DATE${DEFAULT_COLOR} = $DATE"

#время работы системы
UPTIME=$(uptime -p)
echo -e "${PARAMETR_1}UPTIME${DEFAULT_COLOR} = $UPTIME"

#время работы системы в секундах
UPTIME_SECOND=$(awk '{print $1}' /proc/uptime)
echo -e "${PARAMETR_1}UPTIME_SECOND${DEFAULT_COLOR} = $UPTIME_SECOND seconds"

#ip-адрес машины в любом из сетевых интерфейсов
IP=$(ip a | awk '{print $2}' | awk '(NR==3)')
echo -e "${PARAMETR_1}IP${DEFAULT_COLOR} = $IP"

#сетевая маска любого из сетевых интерфейсов в виде: xxx.xxx.xxx.xxx
MASK=$(ip a | awk '{print $2}' | awk '(NR==2)')
echo -e "${PARAMETR_1}MASK${DEFAULT_COLOR} = $MASK"

#ip шлюза по умолчанию
GATEWAY=$(ip route | awk '{print $3}' | awk '(NR==1)')
echo -e "${PARAMETR_1}GATEWAY${DEFAULT_COLOR} = $GATEWAY"

#размер оперативной памяти в Гб c точностью три знака после запятой в виде: 3.125 GB
RAM_TOTAL=$(awk '{print $2}' /proc/meminfo | awk '(NR==1)' | awk '{printf "%.3f",$1/1024/1024}')
echo -e "${PARAMETR_1}RAM_TOTAL${DEFAULT_COLOR} = $RAM_TOTAL GB"
RAM_USED=$(free | awk '{print $3}' | awk '(NR==2)' | awk '{printf "%.3f", $1/1024/1024}')
echo -e "${PARAMETR_1}RAM_USED${DEFAULT_COLOR} = $RAM_USED GB"
RAM_FREE=$(free | awk '{print $4}' | awk '(NR==2)' | awk '{printf "%.3f", $1/1024/1024}')
echo -e "${PARAMETR_1}RAM_FREE${DEFAULT_COLOR}  = $RAM_FREE GB"

# размер рутового раздела в Mб с точностью два знака после запятой в виде: 254.25 MB
SPACE_ROOT=$(df -i / | awk '{print $2}' | awk '(NR==2)' | awk '{printf "%.2f", $1/1024}')
SPACE_ROOT_FREE=$(df -i / | awk '{print $4}' | awk '(NR==2)' | awk '{printf "%.2f", $1/1024}')
SPACE_ROOT_USED=$(df -i / | awk '{print $3}' | awk '(NR==2)' | awk '{printf "%.2f", $1/1024}')
echo -e "${PARAMETR_1}SPACE_ROOT${DEFAULT_COLOR} = $SPACE_ROOT MB"
echo -e "${PARAMETR_1}SPACE_ROOT_USED${DEFAULT_COLOR} = $SPACE_ROOT_USED MB"
echo -e "${PARAMETR_1}SPACE_ROOT_FREE${DEFAULT_COLOR} = $SPACE_ROOT_FREE MB"
}

function main() {
check_parametrs $1 $2 $3 $4
part_2
}
main $1 $2 $3 $4