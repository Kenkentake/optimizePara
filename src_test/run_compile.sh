make clean
make
mpifccpx -Kfast -o make_neuro_spawn make_neuro_spawn.c
mpifccpx -Kfast -o test_est_target test_est_target.c
