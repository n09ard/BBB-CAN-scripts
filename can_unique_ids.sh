#!/bin/bash

function f_usage() {
	echo "Usage: $0 CANLOG"
}

function f_get_ids() {
	cat $1 | cut -b-19 | sort -k5 -u | cut -b17-
}

if [ $# -ne 1 ]
then
	f_usage
	exit 1
fi

f_get_ids $1
