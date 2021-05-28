#ifndef MYRANDOM_H
#define MYRANDOM_H

#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <math.h>
#include <string.h>
#include <float.h>

/* --- PRIVATE DATA --- */ 
typedef struct seed_s {
    double system_parameter;
    double initial_value;
    int iterations;
} seed_t;


/* --- PUBLIC FUNCTION --- */


/**
 * Setting the initial value of the logistic chaotic system to the value 
 * passed as argument
 * 
 * @param seed address of the seed struct used to store the system parameters
 * @param initial_value_new initial value of the system
 * @param system_parameter_new system parameter mu
 * @param iterations_new number of iterations 
 * 
 * @return void
 */ 
void seed_init(seed_t *seed, double initial_value_new, double system_parameter_new, int iterations_new);

/**
 * Generate the new system parameter in according to the previous 
 * system parameter
 * 
 * @param old_param the current system parameter
 * 
 * @return the new system parameter
 */ 
double generate_new_param(double old_paramater);

/**
 * Generate the new number of iteration in according to the previous 
 * number of iteration
 * 
 * @param old_iteration the current number of iteration
 * 
 * @return the new number of iteration
 */ 
int generate_new_iteration(int old_iteration);

/**
 * Given a particular seed, generate a single pseudo-random number following the 
 * logistic chaotic equation:
 * 
 *       X_{n+1} = mu * X_n * (1 - X_n),     n = 0, 1, 2, ... , N_iterations
 * 
 * @param seed the seed containg all the information about the system
 * 
 * @return the pseudo-random number generated by the algorithm
 */ 
double random_generator(seed_t seed);

/**
 * Given a particular seed, generate a sequence of pseudo-random numbers
 * following the logistic chaotic equation:
 * 
 *       X_{n+1} = mu * X_n * (1 - X_n),     n = 0, 1, 2, ... , N_iterations
 * 
 * The sequence is stored in the .txt file "output_sequence.txt" in order to 
 * provide further analysis.
 * 
 * @param seed the seed containg all the information about the system
 * @param length how many numbers in the sequence are required
 * 
 * @return 0 for success, 1 for error
 */ 
int random_sequence_generator(seed_t seed, int length);

/**
 * Provides the re-arrangement of the 13 number sequence after the output generated by the
 * Logistic Map at the n-th iteration. 
 * 
 * @param number_str string containing the output of the Logistic Map
 * @param end maximum length of the re-arrangement
 * 
 * @return the integer number re-arranged
 */ 
long long int sequence_rearrangement(char *number_str, int end);

#endif /* MYRANDOM_H */