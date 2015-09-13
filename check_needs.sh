#! /bin/sh
#
# check_needs.sh
# Copyright (C) 2015 djp <djp@transit>
#
# Distributed under terms of the MIT license.
#


# This script is intended for use in assigning a need:value for all +PENDING tasks.
# when it is run, it assigns a default value of "4", and provides instructions
# on how to assign need:value to tasks with specific projects or tags.  
NUM_0=`task rc.verbose= rc.context= +PENDING need.none: count`
if [[ ${NUM_0} == '0' ]] then
	echo -e "You have a need-level assigned to every task, that's great!"
    exit 0
if [[ ${NUM_0} > '0' ]] then 
	echo -e "You have $NUM_0 tasks with no need-level assigned.
	Would you like to assign those an a default level of $NUM_DEF? (y/n)"
exit 0
