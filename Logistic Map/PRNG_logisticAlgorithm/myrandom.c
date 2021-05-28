#include "myrandom.h"

#define FILENAME "/Users/davidearcolini/Desktop/PoliTo/Reti e sistemi complessi - fenomeni fisici ed interazioni sociali/Tesina/MatLab/Logistic Map/output_sequence.txt"
#define DIGITS 16
#define SHUFFLE_LIMIT 4

#undef FLT_ROUNDS
#undef DBL_DIG
#undef DBL_EPSILON
#define FLT_ROUNDS -1
#define DBL_DIG 17
#define DBL_EPSILON 1E-17

static int rand_n(int n) {
    return rand() % n;
}

/* --- PUBLIC FUNCTION --- */
void seed_init(seed_t *seed, double initial_value_new, double system_parameter_new, int iterations_new) {
    seed->initial_value = initial_value_new;
    seed->system_parameter = system_parameter_new;
    seed->iterations = iterations_new;
    return;
}
double random_generator(seed_t seed) {

    double old_value = seed.initial_value;
    double new_value = 0.0000;
    for (int i = 0; i < seed.iterations; i++) {
        new_value = seed.system_parameter*old_value*(1 - old_value);
        old_value = new_value;
    }
    return new_value;
}
double generate_new_param(double old_parameter) {
    double param_tmp = old_parameter + (double)3.5699;

    while (param_tmp > 4) {
        old_parameter = fmod(param_tmp, (double)4.0000);
        param_tmp = old_parameter + (double)3.5699;
    }
    return param_tmp;
}
int generate_new_iteration(int old_iteration) {
    if (old_iteration < 1000) {
        return old_iteration + 1000;
    }
    return old_iteration;
}
long long int sequence_rearrangement(char *number_str, int end) {
    char number_arranged[DIGITS];
    for (int i = 0; i < end; i++) {
        number_arranged[i] = number_str[rand_n(DIGITS)];
    }
    return atoll(number_arranged);
}
int random_sequence_generator(seed_t seed, int length) {

    /* --- DATA --- */
    FILE *fp;                                       // File pointer of the output file
    char float_number_str[DIGITS+3];                // '0' + '.' + 16 places for the decimal part + '\0'
    char *int_number_str;                           // Result of the strtok() operation     

    char param_str[18];                             // System parameter (type: string)
    char init_str[18];                              // System initial value (type: string)
    char iter_str[5];                               // System iterations (type: string)

    double param_old;                               // System parameter (type: double)
    double init_old;                                // System initial value (type: double)
    int iter_old;                                   // System iterations (type: integer)
    long long output_number;                        // System output before module 256


    /* --- Opening file --- */
    fp = fopen(FILENAME, "w");
    if (fp == NULL) {
        fprintf(stderr, "[ERROR] file opening failed\n");
        return 1;
    }

    /* --- Loop through the sequence --- */
    for (int i = 0; i < floor((length+3)/13); i++) {

        // Converting float to string 
        sprintf(float_number_str, "%.16f", random_generator(seed));
        fprintf(stdout, ">>> %s\n", float_number_str);

        // Converting float to int
        int_number_str = strtok(float_number_str, ".");
        int_number_str = strtok(NULL, "\0");

        // Printing output sequence to file
        srand(time(NULL));
        for (int j = 3; j <= DIGITS; j++) {
            fprintf(fp, "%d\n", sequence_rearrangement(int_number_str, j) % 256);
        }
        
        // Getting subnumbers from float
        sprintf(init_str, "0.%c%c%c%c", int_number_str[0], int_number_str[4], int_number_str[8], int_number_str[12]);
        sprintf(param_str, "0.%c%c%c%c", int_number_str[1], int_number_str[5], int_number_str[9], int_number_str[13]);
        sprintf(iter_str, "%c%c%c%c", int_number_str[2], int_number_str[6], int_number_str[10], int_number_str[14]);

        // Converting string to float/int
        param_old = atof(param_str);
        init_old = atof(init_str);
        iter_old = atoi(iter_str);

        // Generating new seed
        double param_new = generate_new_param(param_old);
        int iter_new = generate_new_iteration(iter_old);

        // Defining new seed
        seed_init(&seed, init_old, param_new, iter_new);
    }

    /* --- Closing file --- */
    fclose(fp);
    return 0;
}
