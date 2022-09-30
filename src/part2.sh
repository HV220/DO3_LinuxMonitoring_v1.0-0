#!/bin/bash

#host_name
hostnamectl | awk '{print $3;} ' | head -1

#full_time
type_zone=$(timedatectl | awk '{print $3}' | awk '(NR ==4)')
time_zone=$(timedatectl | awk '{print $6}' | awk '(NR==2)')
difference_time_zone=$(timedatectl | awk '{print $5}' | awk '(NR==4)' | cut -b -2)
echo $type_zone $time_zone $difference_time_zone;

# user_name
users

#Operation_System
type_OS=$(hostnamectl | awk '{print $3}' | awk '(NR==6)')
version_OS=$(hostnamectl | awk '{print $3}' | awk '(NR==7)')
echo $type_OS $version_OS

#Local_time
date "+%d %B %Y %T"

#Time_of_functioning of system
uptime -p

#Time_of_functioning of system in second
second=$(awk '{print $1}' /proc/uptime)
echo "up in second: $second s"

#ip-адрес машины в любом из сетевых интерфейсов
ip a | awk '(NR==2)'

#_сетевая маска любого из сетевых интерфейсов в виде: **xxx.xxx.xxx.xxx**



