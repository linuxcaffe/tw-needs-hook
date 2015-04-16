#!/bin/bash
#
# Taskwarrior Needs Hierarchy
# a.k.a.Mazlow Mode
UDA_TYPE=`task _get rc.uda.need.type`
if [[ $UDA_TYPE != 'string' ]]
then
echo "You have to define the need uda, do that now? (y/n)"
fi

USAGE="needs [0-6 | auto]"
if [[ ${1} == '' ]]
then
NUM_TOTAL=`task +PENDING count`
NUM_0=`task +PENDING need.none: count`
NUM_1=`task +PENDING need:1 count`
NUM_2=`task +PENDING need:2 count`
NUM_3=`task +PENDING need:3 count`
NUM_4=`task +PENDING need:4 count`
NUM_5=`task +PENDING need:5 count`
NUM_6=`task +PENDING need:6 count`
echo "
    6      /              Higher Goals                \      ($NUM_6)
    5     /            Self Actualization              \     ($NUM_5)
    4    /       Esteem, Respect & Recognition          \    ($NUM_4)
    3   /      Love & Belonging, Friends & Family        \   ($NUM_3)
 -->2  /   Personal safety, security, health, financial   \  ($NUM_2)
    1 /     Physiological; Air, Water, Food & Shelter      \ ($NUM_1)
"
if [[ $NUM_0 != '' ]]
then
echo "You have $NUM_0 of $NUM_TOTAL pending tasks with no need-level set.. fix that!"
fi
exit 0

elif [[ ${1} == 0 ]]
then
echo "Unsetting needs level"
if [[ $WAS_CONTEXT != '' ]]
then
echo "reverting to $WAS_CONTEXT"
# revert to was-context
fi
# set rc.context=
exit 0

elif [[ ${1} != [1-6] ]]
then
echo "Usage: $USAGE"
exit 1
fi

if [[ ${2} != '' ]]
then
echo "Oops! trailing argument!"
exit 1
fi

NEED_LEV=$1
WAS_CONTEXT=`task _get rc.context`
CONJUNCTION=' and '

if [[ $WAS_CONTEXT == '' ]]
then
CONJUNCTION=''
IS_CONTEXT=N$1
echo "No context was previously set. Context is now N$1"

elif [[ $WAS_CONTEXT == $OLD_CONTEXT ]]
then
echo "No change in context"
fi
if [[ $WAS_CONTEXT != '' ]]
then
echo "Context was $WAS_CONTEXT"
task config was.context $WAS_CONTEXT
echo "Setting needs level to $NEED_LEV"
WAS_CONTEXT_FILTER=`task _get rc.context.$WAS_CONTEXT`
echo "filter was $WAS_CONTEXT_FILTER"
IS_CONTEXT="$WAS_CONTEXT.N$1"
task config context $IS_CONTEXT
N_CONTEXT=" not ( need.over:$1 and ( due,before:yesterday or due.after:tomorrow or until:tomorrow ) )"
IS_CONTEXT_FILTER=$WAS_CONTEXT_FILTER$CONJUNCTION$N_CONTEXT
task config context.$1 $IS_CONTEXT_FILTER
exit 0
fi
