#!/bin/bash
#
#######
#
# script for configuration of can interfaces
#
######

function f_usage () {
	echo "Usage: $0 DEVICE BITRATE|up|down|status"
}

function f_down () {
	ip link set $1 down
}

function f_up () {
	ip link set $1 up
	#echo "ip link set $1 up"
}

function f_status () {
	ip link show $1
}

function f_bitrate () {
	ip link set $1 type can bitrate $2
}

function f_convert_bitrate () {
	case "$2" in
	l|low|LOW|100|100000)
		echo "Setting low-speed can"
		f_bitrate $1 100000
		;;
	m|mid|MID|125|125000)
		echo "Setting mid-speed can"
		f_bitrate $1 125000
		;;
	h|high|HIGH|500|500000)
		echo "Setting high-speed can"
		f_bitrate $1 500000
		;;
	*)
		f_usage
		exit 2
		;;
	esac
}

function f_do_action() {

	case $2 in
        	d|down)
                	f_down $1
                	;;
        	u|up)
                	f_up $1
                	;;
        	s|status)
                	f_status $1
                	;;
        	*)
                	f_down $1
                	f_convert_bitrate $1 $2
                	f_up $1
                	f_status $1
                	;;
	esac
}


if [ $# -ne 2 ]
then
	f_usage
	exit 1
fi

# Check first parameter
if [ "$1" = "any" ]
then
	can_dev=`ip link|grep can | cut -f2 -d" "| sed 's/://g'`
	# For each can-device do
	for i in $can_dev
	 do
		#echo ":$i:"
		f_do_action $i $2	
	done
	# Exit normally
	exit 0
fi

# Check second parameter
f_do_action $1 $2
