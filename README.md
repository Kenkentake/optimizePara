# optimizePara
## @Fugaku
### 1. Test for dynamic job 
Job for using MPI_Comm_spawn (not using Estimate_main and NEURON)
```
$ cd src_dynamic_job_test
$ ./run_compile.sh
$ pjsub job_dynamic.sh
```
### 2. Test for optimizePara
Job For using optimzePara (not using NEURON)
```
$ cd src_test
$ ./run_compile.sh
$ pjsub job_test.sh
& pjsub job_python3.sh
```
