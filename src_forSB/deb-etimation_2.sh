#!/bin/bash 
#PJM --rsc-list "node=40"
#PJM --rsc-list "elapse=00:10:00"
#PJM --mpi "max-proc-per-node=16"
#PJM --mpi "shape=1"
#PJM -S


# not to make empty job's output file
export PLE_MPI_STD_EMPTYFILE="off"

# argv for estimate_main
NUM_OF_POP=4
# NUM_OF_POP=2
MU=2
# MU=1
NUM_OF_CHILD_PROCS=2
# NUM_OF_CHILD_PROCS=1
MAXEVAL=4
# NUM_OF_GRANDCHILD_PROCS=16
NUM_OF_GRANDCHILD_PROCS=2
#for take
#EXEC_PROG="/home/hp200177/u00690/neuron_kplus/specials/sparc64/special"
$for kaz
EXEC_PROG="/home/hp200177/u00684/work2/fneuron_kplus/specials/sparc64/special"

DIM_CON_MAT=6
CON_MAT_NAME="../data/conMat_6.txt";
PARAMETER_FILENAME="../data/params_6.txt";


# minimal estimate_main
EXEC_FILE="./estimate_main ${NUM_OF_POP} ${MU} ${NUM_OF_CHILD_PROCS} ${MAXEVAL} ${NUM_OF_GRANDCHILD_PROCS} ${EXEC_PROG} ${DIM_CON_MAT} ${CON_MAT_NAME} ${PARAMETER_FILENAME}"

# execute job for debugger
mpiexec -fjdbg-sig all -fjdbg-out-dir "./log" -np 1 -stdout-proc ./%j/%n -stderr-proc ./%j/%n ${EXEC_FILE}

# 6cells estimate_main.sh
