//! main.cpp is where it all starts. Does option handling and prints a help menu.
//!

#include <iostream>
#include <cstdlib>
#include <getopt.h>

/**
 * @brief      Prints command line usage information.
 */
void print_usage() {
    std::cout << "Usage: binary_name [OPTION...]" << std::endl << std::endl;
    std::cout << "Flags:" << std::endl;
    std::cout << "\t-h\tThis help menu." << std::endl;
}

/**
 * @brief       Where program initially begins.
 */

int main(int argc, char *argv[]) {
    if (argc < 2) {
        print_usage();
        return 1;
    }

    int opt;
    while ((opt = getopt(argc, argv, "b:g:dhc:n:x:")) != -1) {
        switch (opt) {
        case 'h':
            print_usage();
            return 0;
        case '?':
            if (optopt == 'c')
                fprintf(stderr, "Option -%c requires an argument.\n", optopt);
            exit(EXIT_FAILURE);
        case ':':
            fprintf(stderr, "wtf\n");
            exit(EXIT_FAILURE);
        default:
            fprintf(stderr, "Unknown option -%c.\n", optopt);
            print_usage();
            exit(EXIT_FAILURE);
        }
    }
}
