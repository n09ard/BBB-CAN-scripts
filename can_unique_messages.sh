#!/bin/bash

function f_usage() {
	echo "Usage: $0 CANLOG [CAN-ID-FILE]"
}

function f_print_messages() {
	for i in $1
	do
		echo "CAN-ID: $i"
		cat $2 | grep $i | sort -u
	done
}

function f_get_ids() {
	uid=`can_unique_ids $1`
	echo "Unique CAN-IDs:" $uid
}

uid=""

if [ $# -eq 1 ]
then
	f_get_ids $1
elif [ $# -eq 2 ]
then
	uid="`cat $2`"
else
	f_usage
	exit 1
fi

	f_print_messages "$uid" $1

