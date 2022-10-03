#!/bin/bash

source ./part3.sh

function main() {
check_parametrs $1 $2 $3 $4
part_2
}
main $1 $2 $3 $4
