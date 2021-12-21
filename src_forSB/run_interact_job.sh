#!/bin/bash
# mpiexec -np 1 ./estimate_main 4 2 4 4 6 "/home/hp200177/u00690/neuron_kplus/specials/sparc64/special" 6 "../data/conMat_6.txt" "../data/params_6.txt"
mpiexec -np 1 ./estimate_main 4 2 4 4 8 "/vol0004/hp200177/u00690/neuron_kplus/specials/sparc64/special" 6 "../data/conMat_6.txt" "../data/params_6_onlyWeight.txt"
