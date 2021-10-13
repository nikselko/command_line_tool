#ifndef COMMAND_LINE_TOOL_LIB_ARGS_H
#define COMMAND_LINE_TOOL_LIB_ARGS_H

#include <string>
#include <iostream>
#include <vector>

// enumeration with accepted argument types
enum {
    pt_none,
    pt_int,
    pt_float,
    pt_text
};

typedef int param_type;

// option is used for configuring the parser
struct option {
    char short_flag;            // simple char flag for option, e.g. 'h' for help
    std::string long_flag;      // long flag format for option, e.g. "help"
    std::string description;    // option description
    bool accepts_parameter;     // does the option accepts an extra parameter
                                // e.g. in: --input file.txt
                                //      input is the option's flag
                                //      file.txt is the option's parameter
                                // some options do not accept parameter, e.g. --help
    param_type pt;              // what's the parameter type (if accepted): pt_int, pt_float or pt_text
};

// argument is used for parser's output
struct argument{
    std::string long_flag;      // long flag of a recognized option
    param_type pt;              // parameter type
    std::string str_value;      // for pt_text, the value of a parameter
    int int_value;              // for pt_int, the value of a parameter
    double dbl_value;           // for pt_float, the value of a parameter
};

// the main class for parsing
class option_parser{
public:
    option_parser();
    // parses command-line arguments and outputs a parsed vector
    std::vector<argument> parse(const std::string& line);
private:
    std::vector<option> m_options;
    // those should probably be member functions
    friend void add_option(const option& opt);
    friend void remove_option(const std::string& long_flag);
    friend void print_help(std::ostream& out);
};

// adds an option to the parser
void add_option(const option& opt);
// removes an option from the parser
void remove_option(const std::string& long_flag);
// prints program's help
void print_help(std::ostream& out);

// get the parser instance
option_parser& get_parser();





#endif //COMMAND_LINE_TOOL_LIB_ARGS_H
