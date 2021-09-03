#!/bin/bash 
#PJM --rsc-list "rscgrp=small"
#PJM --rsc-list "node=1"
#PJM --rsc-list "elapse=10:00"
#PJM -S

# python3
module load Python3-CN
export FLIB_CNTL_BARRIER_ERR=FALSE

# execute job
python3 judge_results.py
