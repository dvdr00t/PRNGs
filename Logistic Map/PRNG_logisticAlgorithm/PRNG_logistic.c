#include "myrandom.h"

int main (int args, char *argv[]) {

    /* --- Checking parameters --- */
    if (args != 5) {
        fprintf(stderr, "[ERROR]: number of arguments is incorrect.\n"
                        "[USAGE] ./PRNG_logistic system_parameter initial_value iterations sequence_length\n");
        exit(EXIT_FAILURE);
    }

    /* --- Converting string data to numerical data --- */
    double input_sys_param = atof(argv[1]);
    double input_init_val = atof(argv[2]);
    int input_n_iter = atoi(argv[3]);
    int length = atoi(argv[4]);

    /* --- Setting initial seed value --- */
    seed_t seed;
    seed_init(&seed, input_init_val, input_sys_param, input_n_iter);

    /* --- Running simulation of the PRNG --- */
    if (random_sequence_generator(seed, length) == 1) {
        exit(EXIT_FAILURE);
    }
    exit(EXIT_SUCCESS);
}

