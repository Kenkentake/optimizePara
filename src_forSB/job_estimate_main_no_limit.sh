#!/bin/bash 
#PJM --rsc-list "node=8"
#PJM -L "elapse=1:00:00"
#PJM --mpi "shape=1"
#PJM --mpi "max-proc-per-node=8"
#PJM -S

# not to make empty job's output file
export PLE_MPI_STD_EMPTYFILE="off"


# argv for estimate_main
NUM_OF_POP=16
MU=8
NUM_OF_CHILD_PROCS=7
MAXEVAL=4
NUM_OF_GRANDCHILD_PROCS=3
EXEC_PROG="/home/hp200177/u00690/neuron_kplus/specials/sparc64/special"
DIM_CON_MAT=86
CON_MAT_NAME="../data/conMat.txt";
PARAMETER_FILENAME="../data/params_64_onlyWeight.txt";

# MPIEXEC="mpiexec -mca mpi_print_stats 1"
# NPROC="-n 1"
# PROF=""

# minimal estimate_main
EXEC_FILE="./estimate_main ${NUM_OF_POP} ${MU} ${NUM_OF_CHILD_PROCS} ${MAXEVAL} ${NUM_OF_GRANDCHILD_PROCS} ${EXEC_PROG} ${DIM_CON_MAT} ${CON_MAT_NAME} ${PARAMETER_FILENAME}"

# execute job
mpiexec -np 1 ${EXEC_FILE}
