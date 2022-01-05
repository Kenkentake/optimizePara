#!/bin/bash 
#PJM --rsc-list "node=384"
#PJM --rsc-list "elapse=72:00:00"
#PJM --mpi "max-proc-per-node=8"
#PJM --mpi "proc=1"
#PJM -S


# not to make empty job's output file
export PLE_MPI_STD_EMPTYFILE="off"

# argv for estimate_main
NUM_OF_POP=4
MU=2
NUM_OF_CHILD_PROCS=4
MAXEVAL=10
NUM_OF_GRANDCHILD_PROCS=86
EXEC_PROG="/home/hp200177/u00690/neuron_kplus/specials/sparc64/special"
DIM_CON_MAT=86
CON_MAT_NAME="../data/conMat_86.txt";
PARAMETER_FILENAME="../data/params_86_onlyWeight.txt";
JOB_NAME="test_86cells"

# MPIEXEC="mpiexec -mca mpi_print_stats 1"
# NPROC="-n 1"
# PROF=""

# minimal estimate_main
EXEC_FILE="./estimate_main ${NUM_OF_POP} ${MU} ${NUM_OF_CHILD_PROCS} ${MAXEVAL} ${NUM_OF_GRANDCHILD_PROCS} ${EXEC_PROG} ${DIM_CON_MAT} ${CON_MAT_NAME} ${PARAMETER_FILENAME} ${JOB_NAME}"

# execute job
mkdir results/${JOB_NAME}
mpiexec -np 1 -stdout-proc ./%j/%n -stderr-proc ./%j/%n ${EXEC_FILE}

# 6cells estimate_main.sh
