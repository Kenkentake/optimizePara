#!/bin/bash
make clean
rm estimate_main
make
lambda=16
mu=8
spawn_numprocs=2
maxevals=4
num_of_nrn_procs=4
exec_prog="../hocfile_forSB/x86_68/special"
dim_con_mat=2
connection_data="../data/conMat.txt"
range_filename="../data/params_6.txt"
mpirun -np 1 ./estimate_main ${lambda} ${mu} ${spawn_numprocs} ${maxevals} ${num_of_nrn_procs} ${exec_prog} ${dim_con_mat} ${connection_data} ${range_filename} 
# mpirun -np 2 -output-filename output_mpirun.txt ./estimate_main ${lambda}
