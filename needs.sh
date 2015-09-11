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
NUM_TOTAL=`task rc.verbose= rc.context= +PENDING count`
NUM_0=`task rc.verbose= rc.context= +PENDING need.none: count`
NUM_1=`task rc.verbose= rc.context= +PENDING need:1 count`
NUM_2=`task rc.verbose= rc.context= +PENDING need:2 count`
NUM_3=`task rc.verbose= rc.context= +PENDING need:3 count`
NUM_4=`task rc.verbose= rc.context= +PENDING need:4 count`
NUM_5=`task rc.verbose= rc.context= +PENDING need:5 count`
NUM_6=`task rc.verbose= rc.context= +PENDING need:6 count`
# TODO: calculate and display lowest need-level indication ( --> )
echo -e "            __________________________________________
    6      /              Higher goals                \      ($NUM_6)
    5     /            Self actualization              \     ($NUM_5)
    4    /        Esteem, respect & recognition         \    ($NUM_4)
    3   /       Love & belonging, friends & family       \   ($NUM_3)
 -->2  /   Personal safety, security, health, financial   \  ($NUM_2)
    [1;31m1 / Physiological; air, water, food, shelter & medical \ ($NUM_1)[0m
"
  if [[ $NUM_0 != '0' ]]
    then
      echo "You have $NUM_0 of $NUM_TOTAL pending tasks with no need-level set.. fix that!"
  fi
  if [[ $NUM_TOTAL/$NUM_0 < '10' ]]
    then
      echo "This extension will only work when most (if not all) have need:1-6"
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
      echo "Usage: $USAGE"
      exit 1
  fi

NEED_LEV=$1
CONJUNCTION=' and '

# TODO: fix everything below!! all fscked up!

# find current context, 
WAS_CONTEXT=`task _get rc.context`

# save if any

# define new context

# apply new context

# reset previous context


  if [[ $WAS_CONTEXT == '' ]]
    then
      CONJUNCTION=''
      IS_CONTEXT=N$1
      echo "No context was previously set. Context is now $IS_CONTEXT"

  elif [[ $WAS_CONTEXT == $OLD_CONTEXT ]]
    then
      echo "No change in context"
  fi
  if [[ $WAS_CONTEXT != '' ]]
    then
      echo "Context was $WAS_CONTEXT"
      task confirmation=off config was.context $WAS_CONTEXT
      echo "Setting needs level to $NEED_LEV"
      WAS_CONTEXT_FILTER=`task _get rc.context.$WAS_CONTEXT`
      echo "filter was $WAS_CONTEXT_FILTER"
      IS_CONTEXT="$WAS_CONTEXT .N$1"
      task confirmation=off config context $IS_CONTEXT
      N_CONTEXT="tw '! ((need.over:$NEED_LEV or need.under:1) and ! (due:today or until:tomorrow))'"
      IS_CONTEXT_FILTER=$WAS_CONTEXT_FILTER$CONJUNCTION$N_CONTEXT
      task confirmation=off config context.$1 $IS_CONTEXT_FILTER
      exit 0
  fi
