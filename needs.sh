#!/bin/bash
#
# Taskwarrior Needs Hierarchy
# a.k.a.Mazlow Mode
TASK=task
UDA_TYPE=`task _get rc.uda.need.type`
  if [[ $UDA_TYPE != 'string' ]]
    then
      echo "You have to define the need uda, do that now? (y/n)"
  fi

STATUS="ok"
USAGE="needs [0-6 | auto]"
NEED_LEV=`task _get rc.needlevel`
  if [[ "$NEED_LEV" == "" ]] 
    then
	echo "needlevel config not set.. set it now?"
      # if yes, 'task config needlevel 0'
      STATUS="nok"
  fi

# Functions
function pause(){
  read -p "$*"
  }

# PRINT NEEDS REPORT
  if [[ $1 == '' ]]
    then
# COUNT TASKS
CONFIG="rc.verbose= rc.confirmation= rc.context= +PENDING"
NUM_TOTAL=`task $CONFIG count`
NUM_0=`task $CONFIG need.none: count`
NUM_1=`task $CONFIG need:1 count`
NUM_2=`task $CONFIG need:2 count`
NUM_3=`task $CONFIG need:3 count`
NUM_4=`task $CONFIG need:4 count`
NUM_5=`task $CONFIG need:5 count`
NUM_6=`task $CONFIG need:6 count`

# COLORS
GRAY="[38;5;242m"
C1="[1;31m"		# bold red
CB1=$C1
  if [[ "$NUM_1" -lt "1" ]]
    then
      CB1=$GRAY
  fi
C2="[33m"		# yellow
CB2=$C2
  if [[ "$NEED_LEV" =~ [156]+ ]] || [[ "$NUM_2" -lt "1" ]]
    then
      CB2=$GRAY
  fi
C3="[32m"		# green
CB3=$C3
  if [[ "$NEED_LEV" =~ [126]+ ]] || [[ "$NUM_3" = "1" ]]
    then
      CB3=$GRAY
  fi
C4="[1;34m"		# bold blue
CB4=$C4
  if [[ "${NEED_LEV}" =~ [1-3]+ ]] || [[ "$NUM_4" -lt "1" ]]
    then
      CB4=$GRAY
  fi
C5="[36m"		# cyan
CB5=$C5
  if [[ "$NEED_LEV" =~ [1-4]+ ]] || [[ "$NUM_5" -lt "1" ]]
    then
      CB5=$GRAY
  fi
C6="[35m"		# magenta
CB6=$C6
  if [[ "$NEED_LEV" =~ [1-5]+ ]] || [[ "$NUM_6" -lt "1" ]]
    then
      CB6=$GRAY
  fi
Cx="[0m"		# end color

# BAR GRAPH (50 bars across)
# if count=1, assign 1 bar, to be non-zero on graph
B_FACTOR=`echo "50 $NUM_TOTAL" |awk '{printf "%.8f \n", $1/$2}'`
B_MIN="1"
B0=`echo "$NUM_0 $B_FACTOR" |awk '{printf "%.f \n", $1*$2}'`
  if [[ "$NUM_0" == "$B_MIN" ]] 
     then B0="1"
  fi
B1=`echo "$NUM_1 $B_FACTOR" |awk '{printf "%.f \n", $1*$2}'`
  if [[ "$NUM_1" == "$B_MIN" ]] 
     then B1="1"
  fi
B2=`echo "$NUM_2 $B_FACTOR" |awk '{printf "%.f \n", $1*$2}'`
  if [[ "$NUM_2" == "$B_MIN" ]] 
     then B2="1"
  fi
B3=`echo "$NUM_3 $B_FACTOR" |awk '{printf "%.f \n", $1*$2}'`
  if [[ "$NUM_3" == "$B_MIN" ]] 
     then B3="1"
  fi
B4=`echo "$NUM_4 $B_FACTOR" |awk '{printf "%.f \n", $1*$2}'`
  if [[ "$NUM_4" == "$B_MIN" ]] 
     then B4="1"
  fi
B5=`echo "$NUM_5 $B_FACTOR" |awk '{printf "%.f \n", $1*$2}'`
  if [[ "$NUM_5" == "$B_MIN" ]] 
     then B5="1"
  fi
B6=`echo "$NUM_6 $B_FACTOR" |awk '{printf "%.f \n", $1*$2}'`
  if [[ "$NUM_6" == "$B_MIN" ]]
     then B6="1"

# FIND THE LARGEST GROUP TO USE FOR LEVELLING
  fi
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
B_TOT=$((B0 + B1 + B2 + B3 + B4 + B5 + B6 ))

if [[ "$B_TOT" -gt "50" ]]
  then
  B_TRIM=$((B_TOT - 50 ))
  B_LEV=B$BIG_L
# TODO fix this leveller
#  `eval echo \$$B_LEV`=$((BIG_B - B_TRIM))
 # $(`echo "$B_LEV"`)=$((BIG_B - B_TRIM))
# DIAGNOSTIC
#echo "$NUM_TOTAL"
#echo "$B_FACTOR"
#echo "1 $B1"
#echo "2 $B2"
#echo "3 $B3"
#echo "4 $B4"
#echo "5 $B5"
#echo "6 $B6"
#echo "BIG_B $BIG_B"
#echo "BIG_L $BIG_L"
#echo "B_TOT $B_TOT"
#echo "B_LEV $B_LEV"
#echo "B_TRIM $B_TRIM"
fi

# CONVERT PERCENTAGE TO NUMBER OF "_"s
# TODO fix "printf: 0 : invalid number"
G0=`printf '%*s' "$B0" | tr ' ' "x"`
G1=`printf '%*s' "$B1" | tr ' ' "_"`
G2=`printf '%*s' "$B2" | tr ' ' "_"`
G3=`printf '%*s' "$B3" | tr ' ' "_"`
G4=`printf '%*s' "$B4" | tr ' ' "_"`
G5=`printf '%*s' "$B5" | tr ' ' "_"`
G6=`printf '%*s' "$B6" | tr ' ' "_"`
echo "$G0 $G1 $G2 $G3 $G4 $G5 $G6"
echo "$B0 $B1 $B2 $B3 $B4 $B5 $B6"
# LEVEL INDICATOR (first column)
# AND, AT THE SAME TIME, CALCULATED TASKS SUB-TOTAL
SPC="    "
ACT=" -->"
SUB_TOT="0"
AUTO_LEV="6"
I6=$SPC
  if [[ "$NEED_LEV" == "6" ]]
    then
      I6="$ACT"
      SUB_TOT=$((NUM_6 + NUM_5 + NUM_4))
  fi
I5=$SPC
  if [[ "$NEED_LEV" == "5" ]]
    then
      I5="$ACT"
      SUB_TOT=$((NUM_5 + NUM_4 + NUM_3))
  fi
I4=$SPC
  if [[ "$NEED_LEV" == "4" ]]
    then
      I4="$ACT"
      SUB_TOT=$((NUM_4 + NUM_3 + NUM_2 + NUM_1))
  fi
I3=$SPC
  if [[ "$NEED_LEV" == "3" ]]
    then
      I3="$ACT"
      SUB_TOT=$((NUM_3 + NUM_2 + NUM_1))
  fi
I2=$SPC
  if [[ "$NEED_LEV" == "2" ]]
    then
      I2="$ACT"
      SUB_TOT=$((NUM_2 + NUM_1))
  fi
I1=$SPC
  if [[ "$NEED_LEV" == "1" ]]
    then
      I1="$ACT"
      SUB_TOT=$NUM_1
  fi
I0="-"
  if [[ "$NEED_LEV" =~ "0" ]]
    then
      SUB_TOT=$NUM_TOTAL
  fi


# NEEDS-AUTO-LEVEL SELECTION
   if [[ "$NUM_6" != "0" ]]; then
     AUTO_LEV="6"
   fi
   if [[ "$NUM_5" != "0" ]]; then
     AUTO_LEV="5"
   fi
   if [[ "$NUM_4" != "0" ]]; then
     AUTO_LEV="4"
   fi
   if [[ "$NUM_3" != "0" ]]; then
     AUTO_LEV="3"
   fi
   if [[ "$NUM_2" != "0" ]]; then
     AUTO_LEV="2"
   fi
   if [[ "$NUM_1" != "0" ]]; then
     AUTO_LEV="1"
   fi

# TODO: calculate and display lowest need-level indication ( --> )
echo -e "            $G0$C1$G1$Cx$CB2$G2$Cx$CB3$G3$Cx$CB4$G4$Cx$CB5$G5$Cx$CB6$G6$Cx
$I6${C6}6${Cx}${CB6}      /                  Higher goals                    \      ${Cx}(${CB6}$NUM_6${Cx})
$I5${C5}5${Cx}${CB5}     /                Self actualization                  \     ${Cx}(${CB5}$NUM_5${Cx})
$I4${C4}4${Cx}${CB4}    /            Esteem, respect & recognition             \    ${Cx}(${CB4}$NUM_4${Cx})
$I3${C3}3${Cx}${CB3}   /           Love & belonging, friends & family           \   ${Cx}(${CB3}$NUM_3${Cx})
$I2${C2}2${Cx}${CB2}  /       Personal safety, security, health, financial       \  ${Cx}(${CB2}$NUM_2${Cx})
$I1${C1}1${Cx}${CB1} /     Physiological; air, water, food, shelter & medical     \ ${Cx}(${CB1}$NUM_1${Cx})"
# IF ANY TASKS ARE MISSING A NEED VALUE
  if [[ $NUM_0 != '0' ]]
    then
      echo "     |--------------------------------------------------------------|"
      echo "     |  You have $NUM_0 of $NUM_TOTAL pending tasks with no need-level set..    |"
  fi

  if [[ $NUM_TOTAL/$NUM_0 < '10' ]]
    then
      echo "     |  For tw-needs-hook to work, most (if not all) have need:1-6  |"
  fi



echo "     \--------------------------------------------------------------/
      \_ Current need level:$NEED_LEV -- enter 0-6, A, help or \"q\" to quit_/ ($SUB_TOT)"

# PROMPT
echo
read -p "   Need>" prompt
 if [[ $prompt =~ [0-6]+ ]]
   then
     if [[ $prompt != $NEED_LEV ]]; then
         task rc.verbose= rc.confirmation= config needlevel $prompt
         #$TASK $CONFIG config needlevel $prompt
         NEED_LEV=`task _get rc.needlevel`
         echo "Need level changed to $NEED_LEV"
	 pause 'Press <CR> to continue...'
	 $TASK needs
	 exit 0
       else
         echo "Need level is already $NEED_LEV, no changes made"
	 pause 'Press <CR> to continue...'
	 $TASK needs
         exit 0
       fi
    fi
  if [[ "$prompt" =~ [Aa]+ ]]; then
          task rc.verbose= rc.confirmation= config needlevel $AUTO_LEV
          NEED_LEV=`task _get rc.needlevel`
	  echo "Need level set to $NEED_LEV automatically" 
	  pause 'Press <CR> to continue...'
	 $TASK needs
	 exit 0
  fi
fi
# ERROR CHECKING

# 
#   elif [[ ${1} == 0 ]]
#     then
#       echo "Unsetting needs level"
#   if [[ $WAS_CONTEXT != '' ]]
#     then
#       echo "reverting to $WAS_CONTEXT"
# # revert to was-context
#   fi
# # set rc.context=
# exit 0
# 
#   elif [[ ${1} != [1-6] ]]
#     then
#       echo "Usage: $USAGE"
#       exit 1
#   fi
# 
#   if [[ ${2} != '' ]]
#     then
#       echo "Oops! trailing argument!"
#       echo "Usage: $USAGE"
#       exit 1
#   fi
# 
# NEED_LEV=$1
# CONJUNCTION=' and '
# exit 0
# 
