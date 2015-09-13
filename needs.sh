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

# PRINT NEEDS REPORT
  if [[ ${1} == '' ]]
    then
# COUNT TASKS
CONFIG="rc.verbose= rc.context= +PENDING"
NUM_TOTAL=`task $CONFIG count`
NUM_0=`task $CONFIG need.none: count`
NUM_1=`task $CONFIG need:1 count`
NUM_2=`task $CONFIG need:2 count`
NUM_3=`task $CONFIG need:3 count`
NUM_4=`task $CONFIG need:4 count`
NUM_5=`task $CONFIG need:5 count`
NUM_6=`task $CONFIG need:6 count`

# COLORS
C1="[1;31m"		# bold red
C2="[33m"		# yellow
C3="[32m"		# green
C4="[1;34m"		# bold blue
C5="[36m"		# cyan
C6="[35m"		# magenta
Cx="[0m"		# end color

# BAR GRAPH
# if count=1, assign 1 bar, to be non-zero on graph
B_FACTOR=`echo "50 $NUM_TOTAL" |awk '{printf "%.8f \n", $1/$2}'`
B0=`echo "$NUM_0 $B_FACTOR" |awk '{printf "%.f \n", $1*$2}'`
  if [[ "$NUM_0" = "1" ]] 
     then B0="1"
  fi
B1=`echo "$NUM_1 $B_FACTOR" |awk '{printf "%.f \n", $1*$2}'`
  if [[ "$NUM_1" = "1" ]] 
     then B1="1"
  fi
B2=`echo "$NUM_2 $B_FACTOR" |awk '{printf "%.f \n", $1*$2}'`
  if [[ "$NUM_2" = "1" ]] 
     then B2="1"
  fi
B3=`echo "$NUM_3 $B_FACTOR" |awk '{printf "%.f \n", $1*$2}'`
  if [[ "$NUM_3" = "1" ]] 
     then B3="1"
  fi
B4=`echo "$NUM_4 $B_FACTOR" |awk '{printf "%.f \n", $1*$2}'`
  if [[ "$NUM_4" = "1" ]] 
     then B4="1"
  fi
B5=`echo "$NUM_5 $B_FACTOR" |awk '{printf "%.f \n", $1*$2}'`
  if [[ "$NUM_5" = "1" ]] 
     then B5="1"
  fi
B6=`echo "$NUM_6 $B_FACTOR" |awk '{printf "%.f \n", $1*$2}'`
  if [[ "$NUM_6" = "1" ]]
     then B6="1"
  fi

# LEVELLING ROUTINE
# if, because of exceptions, the row > 50, trim the difference 
# from the largest group
BIG_B='0'
  if [[ "$B0" -gt "$BIG_B" ]] 
    then
    BIG_B=$B0
    BIG_L=0
  fi
  if [[ "$B1" -gt "$BIG_B" ]] 
    then
    BIG_B=$B1
    BIG_L=1
  fi
  if [[ "$B2" -gt "$BIG_B" ]]
    then
    BIG_B=$B2
    BIG_L=2
  fi
  if [[ "$B3" -gt "$BIG_B" ]]
    then
    BIG_B=$B3
    BIG_L=3
  fi
  if [[ "$B4" -gt "$BIG_B" ]] 
    then
    BIG_B=$B4
    BIG_L=4
  fi
  if [[ "$B5" -gt "$BIG_B" ]]
    then
    BIG_B=$B5
    BIG_L=5
  fi
  if [[ "$B6" -gt "$BIG_B" ]]
    then
    BIG_B=$B6
    BIG_L=6
fi
B_TOT=$(($B0 + $B1 + $B2 + $B3 + $B4 + $B5 + $B6 ))

if [[ "$B_TOT" -gt "50" ]]
then
  B_TRIM=$(($B_TOT - 50 ))
  B_LEV=B$BIG_L

#TODO: fix following line:   
  #  ${B_LEV}=$(($BIG_B - $B_TRIM))
#  B4=$(($BIG_B - $B_TRIM))
fi

# CONVERT PERCENTAGE TO NUMBER OF "_"s
G0=`printf "%*s" "$B0" | tr ' ' "x"`
G1=`printf "%*s" "$B1" | tr ' ' "_"`
G2=`printf "%*s" "$B2" | tr ' ' "_"`
G3=`printf "%*s" "$B3" | tr ' ' "_"`
G4=`printf "%*s" "$B4" | tr ' ' "_"`
G5=`printf "%*s" "$B5" | tr ' ' "_"`
G6=`printf "%*s" "$B6" | tr ' ' "_"`
#G3=`printf '%${B3}s' | tr ' ' _`

# DIAGNOSTIC OUTPUT
echo "$NUM_TOTAL"
echo "$B_FACTOR"
echo "0 $B0"
echo "1 $B1"
echo "2 $B2"
echo "3 $B3"
echo "4 $B4"
echo "5 $B5"
echo "6 $B6"
echo "BIG_B $BIG_B"
echo "BIG_L $BIG_L"
echo "B_TOT $B_TOT"
echo "B_LEV $B_LEV"
echo "B_TRIM $B_TRIM"


# TODO: calculate and display lowest need-level indication ( --> )
echo -e "            $G0$C1$G1$Cx$C2$G2$Cx$C3$G3$Cx$C4$G4$Cx$C5$G5$Cx$C6$G6$Cx
    ${C6}6      /                  Higher goals                    \      ${Cx}(${C6}$NUM_6${Cx})
    ${C5}5     /                Self actualization                  \     ${Cx}(${C5}$NUM_5${Cx})
    ${C4}4    /            Esteem, respect & recognition             \    ${Cx}(${C4}$NUM_4${Cx})
    ${C3}3   /           Love & belonging, friends & family           \   ${Cx}(${C3}$NUM_3${Cx})
 -->${C2}2  /       Personal safety, security, health, financial       \  ${Cx}(${C2}$NUM_2${Cx})
    ${C1}1 /     Physiological; air, water, food, shelter & medical     \ ${Cx}(${C1}$NUM_1${Cx})
"
  if [[ $NUM_0 != '0' ]]
    then
      echo "You have $NUM_0 of $NUM_TOTAL pending tasks with no need-level set.. fix that!"
  fi
  if [[ "$NUM_0" -gt "0" ]]
    then
      RATIO=$(($NUM_TOTAL / $NUM_0))
      if [[ "$RATIO" -gt '10' ]]
        then
        echo "This extension will only work when most (if not all) have need:1-6"
  fi
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
exit 0

