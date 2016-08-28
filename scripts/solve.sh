#!/bin/bash

# Helper script for invoking Z3-str2, CVC4 and ACO-Solver
# run with ./solve.sh (z3str2|cvc4|aco)

#### #### #### #### #### #### #### #### #### #### #### #### #### ####
# Please change the following variables according to your environment

# Location of sushi JAR file
SUSHIJAR=""
# Location of aco JAR file
ACOJAR=""
# Locations of CVC4 and Z3
CVC4BIN=""
Z3BIN=""
# Directory that contains the attack conditions
ACONDDIR=""
# Directory that contains the external solver plugins -- will be loaded automatically
PLUGINDIR=""
# External solver to use (cvc4|z3)
ACOEXT="cvc4"
# You can set a timeout here.
TIMEOUT="15s"
# Use sushi (true|false)
SUSHI_ENABLED="true"
#### #### #### #### #### #### #### #### #### #### #### #### #### ####

FINALRES="report"
RES="/tmp/res"

# classpath
CP=".:${SUSHIJAR}:${ACOJAR}"

function report {
	local fil=$(basename $1)
	local ext=$2
	local status=$(cat $RES | head -n 1)
	local time=$(cat $RES | tail -n 1 | egrep -o '[0-9.]+')
	printf "%s,%s,%s\n" "${fil}" "${status}" "${time}" >> "${FINALRES}.${ext}"
}

function solveCVC4 {
	local files=$(find $ACONDDIR -name "*.cvc4" -not -name "${FINALRES}.cvc4")
	echo "" > "${FINALRES}.cvc4"
	for fil in $files; do
		echo "solve $fil ..."
		local out=$(timeout $TIMEOUT /usr/bin/time -p $CVC4BIN --lang smt $fil 2>&1 | egrep '(UNKNOWN|sat|real)')
		[ ! \( $? -eq 0 \) ] && {
			echo -e "${fil},timeout,${time}" >> "${FINALRES}.cvc4"
			echo "timeout ... continue"
			continue
		}
		echo "$out" > $RES
		if [[ ( $out == *"sat"* || $out == *"UNKNOWN"* ) && ( $out == *"real"* ) ]]; then
			report "$fil" "cvc4"
		else
			printf "%s\t\t%s\n" "$(basename ${fil})" "FAIL" >> "${FINALRES}.cvc4"
		fi
		echo "... done"
	done
}

function solveZ3 {
	local files=$(find $( cd $ACONDDIR; pwd) -name "*.z3str2" -not -name "${FINALRES}.z3str2")
	echo "" > "${FINALRES}.z3str2"
	local cur="$(PWD)"
	for fil in $files; do
		echo "solve $fil ...$Z3BIN -f $fil "
		cd "$(dirname $Z3BIN)"
		local out=$(timeout $TIMEOUT /usr/bin/time -p $Z3BIN -f $fil 2>&1 | egrep '(UNKNOWN|SAT|real)')
		[ ! \( $? -eq 0 \) ] && {
			echo -e "${fil},timeout,${time}" >> "${FINALRES}.z3str2"
			echo "timeout ... continue"
			continue
		}
		cd "$cur";
		echo "$out" > $RES
		if [[ ( $out == *"SAT"* || $out == *"UNKNOWN"* ) && ( $out == *"real"* ) ]]; then
			report "$fil" "z3str2"
		else
			printf "%s\t\t%s\n" "$(basename ${fil})" "FAIL" >> "${FINALRES}.z3str2"
		fi
		echo "... done"
	done
}

function solveACO {
	local acoinv="java -cp ${CP} org.snt.helix.core.Helix -pdir $PLUGINDIR -solver ${ACOEXT} -pconf cvc4bin=${CVC4BIN} -setprep ${SUSHI_ENABLED}"
	local files=$(find ${ACONDDIR} -name "*.sol" -not -name "${FINALRES}.sol")
	echo "" > "${FINALRES}.sol"
	for fil in $files; do
		echo "solve ${fil} ..."
		local cmd="${acoinv} -cfg $fil"
		local out=$(timeout $TIMEOUT /usr/bin/time -p $cmd 2>&1 | egrep '(ISSAT|ISUNSAT|real)')
		[ ! \( $? -eq 0 \) ] && {
			echo -e "${fil},timeout,${time}" >> "${FINALRES}.sol"
			echo "timeout ... continue"
			continue
		}
		echo "${out}" > "${RES}"
		if [[ ( $out == *"ISSAT"* || $out == *"UNKNOWN"* || $out == *"ISUNSAT"*) && ( $out == *"real"* ) ]]; then
			report "${fil}" "sol"
		else
			printf "%s\t\t%s\n" "$(basename ${fil})" "FAIL" >> "${FINALRES}.sol"
		fi
		cd "${cur}"
		echo "... done"
	done
}

INPUT="$1"

[ \( "${INPUT}" = "z3str2" \) -o \( "${INPUT}" = "cvc4" \) -o \( "${INPUT}" = "aco" \) ] && {
	if [ "${INPUT}" = "z3str2" ]; then
		solveZ3
	elif [ "${INPUT}" = "cvc4" ]; then
		solveCVC4
	elif [ "${INPUT}" = "aco" ]; then
		solveACO
	fi
	exit 0
}

echo "call with $0 (z3str|cvc4|aco)"
exit 1
