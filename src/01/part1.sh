#!/bin/bash

function part_1() {
re='^[+-]?[0-9]+([.][0-9]+)?$'
if ! [[ $1 =~ $re ]] ; then
    echo $1;
else
    echo "error: number";
fi
}
