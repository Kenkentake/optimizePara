make clean
make
mpifccpx -g -Kfast -o make_neuro_spawn make_neuro_spawn.c
mpifccpx -g -Kfast -o test_est_target test_est_target.c
