#!/bin/bash
#
# Taskwarrior Needs Hierarchy
# a.k.a.Mazlow Mode
USAGE="needs [0-6 | auto]"
OLD_CONTEXT=`task _get rc.old.context`
if [[ ${1} == '' ]]
then
echo "
    6      /              Higher Goals                \      (2)
    5     /            Self Actualization              \     (2)
    4    /       Esteem, Respect & Recognition          \   (17)
    3   /      Love & Belonging, Friends & Family        \  (32)
 -->2  /   Personal safety, security, health, financial   \  (2)
    1 /     Physiological; Air, Water, Food & Shelter      \ (0)
"
exit 0
elif [[ ${1} == 0 ]]
then
echo "Unsetting needs level"
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
echo "No context was set"

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
N_CONTEXT="( not need.over:$1 and ( due,before:yesterday or due.after:tomorrow or until:tomorrow ) )"
IS_CONTEXT_FILTER=$WAS_CONTEXT_FILTER$CONJUNCTION$N_CONTEXT
task config context.$1 $IS_CONTEXT_FILTER
exit 0
fi
