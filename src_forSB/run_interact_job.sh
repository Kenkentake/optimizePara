#!/bin/bash

# argv for estimate_main
NUM_OF_POP=8
MU=4
NUM_OF_CHILD_PROCS=4
MAXEVAL=8
NUM_OF_GRANDCHILD_PROCS=6
EXEC_PROG="/vol0004/hp200177/u00690/neuron_kplus/specials/sparc64/special"
DIM_CON_MAT=6
CON_MAT_NAME="../data/conMat_6.txt";
PARAMETER_FILENAME="../data/params_6_onlyWeight.txt";
JOB_NAME="test_8_generation"

# minimal estimate_main
EXEC_FILE="./estimate_main ${NUM_OF_POP} ${MU} ${NUM_OF_CHILD_PROCS} ${MAXEVAL} ${NUM_OF_GRANDCHILD_PROCS} ${EXEC_PROG} ${DIM_CON_MAT} ${CON_MAT_NAME} ${PARAMETER_FILENAME} ${JOB_NAME}"


# execute job
mkdir results/${JOB_NAME}
mpiexec -np 1  ${EXEC_FILE} 1> stdout.log 2> stderr.log
