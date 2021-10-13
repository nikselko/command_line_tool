//
// Created by dza02 on 9/28/2021.
//

#include "program.h"

program::program(const std::vector<argument>& arguments):
m_arguments{arguments}
{}

void program::run() {
    // check if there was a help request
    for (const auto& arg: m_arguments){
        if (arg.long_flag == "help"){
            print_help(std::cout);
            break;
        }
    }

    // for debug only: print all the arguments passed to the program
    std::cout << "\nThe following arguments were passed to the program: \n";
    for (const auto& arg: m_arguments){
        std::cout << arg.long_flag;
        switch (arg.pt){
            case pt_text:
                std::cout << ": " << arg.str_value;
                break;
            case pt_float:
                std::cout << ": " << arg.dbl_value;
                break;
            case pt_int:
                std::cout << ": " << arg.int_value;
                break;
            default:
                break;
        }
        std::cout << '\n';
    }
}
