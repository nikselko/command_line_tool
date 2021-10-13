#include "lib_args.h"
#include <sstream>

// the one and only parser instance
static option_parser parser{};

// and a function to get this instance
option_parser& get_parser(){
    return parser;
}

void add_option(const option& opt) {
    parser.m_options.push_back(opt);
}

void remove_option(const std::string& long_flag) {
    for (auto iter = parser.m_options.begin(); iter != parser.m_options.end(); ++iter){
        if (iter->long_flag == long_flag){
            parser.m_options.erase(iter);
            break;
        }
    }
}

// just iterate over the options and print their help
void print_help(std::ostream& out) {
    out << "Program help\n";
    for (auto& opt: parser.m_options){
        out << '-' << opt.short_flag << ", ";
        out << "--" << opt.long_flag << '\t';
        out << opt.description << '\n';
    }
}

// two helper functions hidden in the source file
static bool is_short_flag(const std::string& flag){
    return flag.length() == 2 && flag[0] == '-' && flag[1] != '-';
}

static bool is_long_flag(const std::string& flag){
    return flag.length() >= 4 && flag[0] == '-' && flag[1] == '-';
}

option_parser::option_parser():
m_options{}{
    // add the default help option
    m_options.push_back(option{'h', "help", "prints this help", false, pt_none});
}

// parses a line with all the command-line arguments and produces a vector with recognized arguments
std::vector<argument> option_parser::parse(const std::string& line) {

    std::vector<argument> result{};

    std::istringstream iss{line};
    std::string token{};

    // current_option is not null if the next token is expected to be an extra argument
    // e.g. in "--input code.cpp": "--input" is an option's flag and "code.cpp" an extra argument
    //
    // if the last parsed token was "--input" then `current_option` would point
    // to an option associated with the "input" flag. In the next iteration "code.cpp" would be parsed.
    // this way the currently selected option can be linked with its argument

    option* current_option{nullptr};

    while(iss >> token){
        if (current_option == nullptr){
            // if awaiting a new flag, try to match it
            if (is_short_flag(token)) {
                for (auto& opt: m_options) {
                    if (opt.short_flag == token[1]){
                        current_option = &opt;
                        break;
                    }
                }
            }
            else if (is_long_flag(token)){
                for (auto& opt: m_options) {
                    if (opt.long_flag == token.substr(2)){
                        current_option = &opt;
                        break;
                    }
                }
            }

            // if a flag was recognized and a matching option has been found
            if (current_option != nullptr) {
                // and this options doesn't need extra arguments, just add it to the results
                if (!current_option->accepts_parameter) {
                    result.push_back({current_option->long_flag, pt_none, "", 0, 0.0});
                    current_option = nullptr;
                }
            }
        }
        else {
            // a flag was recognized in the previous iteration and an option was matched that needs an argument

            // create an empty argument structure
            argument arg{current_option->long_flag, current_option->pt, "", 0, 0.0};

            // parse the extra argument passed in command line
            switch (current_option->pt){
                case pt_int:
                    arg.int_value = std::stoi(token);
                    break;
                case pt_float:
                    arg.dbl_value = std::stod(token);
                    break;
                case pt_text:
                    arg.str_value = token;
                    break;
            }

            // add the fully parsed option+argument to results
            result.push_back(arg);
            current_option = nullptr;
        }
    }

    return result;
}
