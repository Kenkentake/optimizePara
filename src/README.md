# src
Steps to run estimate_main in src on Cluster
#### 1. Copy mod files to Neuron Kplus
```
$ cp *.mod ~/neuron_kplus/mod
```

#### 2. Compile Neuron Kplus
Check [here](https://github.com/sc4brain/neuron_kplus)
```
$ cp ~/neuron_kplus/specials/x86_64/special ./
```

#### 3. Compile and run estimate_main
```
$ ./run_estimate_main.sh
```
