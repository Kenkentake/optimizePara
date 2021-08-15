#!/bin/bash 
#PJM --rsc-list "rscgrp=small"
#PJM --rsc-list "node=357"
#PJM --rsc-list "elapse=03:40:00"
#PJM --mpi "proc=8"
#PJM --mpi "shape=1"

#PJM --rsc-list "rscunit=rscunit_ft01"
#PJM -S

module load lang
export OMP_NUM_THREADS=8

export PARALLEL=8
export OMP_WAIT_POLICY=ACTIVE

NRNIV="/home/hp200177/u00690/neuron_kplus/specials/sparc64/special -mpi"


MPIEXEC="mpiexec -mca mpi_print_stats 1"
NPROC="-n 1"
PROF=""
EXEC_FILE="./estimate_main 32 16 32 15 86"

echo "${PROF} ${MPIEXEC} ${NPROC} ${EXEC_FILE}"
time  ${PROF} ${MPIEXEC} ${NPROC} ${EXEC_FILE}

sync
