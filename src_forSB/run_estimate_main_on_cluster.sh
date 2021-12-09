#!/bin/bash
make clean
rm estimate_main
make
mpicc -O3 -o make_neuro_spawn make_neuro_spawn.c
lambda=4
mu=2
spawn_numprocs=4
maxevals=15
num_of_nrn_procs=86
exec_prog="../hocfile_forSB/x86_64/special"
dim_con_mat=86
connection_data="../data/conMat.txt"
range_filename="../data/params_onlyWeight.txt"
mpirun -np 1 ./estimate_main ${lambda} ${mu} ${spawn_numprocs} ${maxevals} ${num_of_nrn_procs} ${exec_prog} ${dim_con_mat} ${connection_data} ${range_filename}
