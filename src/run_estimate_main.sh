#!/bin/bash
make clean
make
mpirun -np 2 ./estimate_main
