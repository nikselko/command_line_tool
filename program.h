#ifndef COMMAND_LINE_TOOL_PROGRAM_H
#define COMMAND_LINE_TOOL_PROGRAM_H
#include "lib_args.h"

class program {
public:
    program(const std::vector<argument>& arguments);
    void run();

private:
    std::vector<argument> m_arguments;
};


#endif //COMMAND_LINE_TOOL_PROGRAM_H
