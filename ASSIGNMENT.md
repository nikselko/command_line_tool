---
title: Advanced Programming Concepts
# author: Dawid Zalewski
date: \today
keywords: [C++, SOLID, OOP]

colorlinks: true
lang: en-US
papersize: a4
fontsize: 11pt
geometry:
- top=25mm
- bottom=25mm
- left=20mm
- right=20mm

listings-no-page-break: false
footnotes-pretty: false
header-left: "\\thetitle \\hspace{0.1em} | Week 3"
header-right: "\\theauthor"
footer-left: "Version: \\today"

header-includes:
- |
  ```{=latex}
  \usepackage{awesomebox}
  ```
pandoc-latex-environment:
  noteblock: [note]
  tipblock: [tip]
  warningblock: [warning]
  cautionblock: [caution]
  importantblock: [important]

...

# Assignment 1

## Introduction

*Command line arguments* are arguments that are passed by the environment to a program when it starts. 
For instance, the shell command `cp` used to copy files and directories, can be invoked with:

```shell
cp -f --recursive ./doc/ ./arch/ 
```

This command will copy the *doc* directory and its content into the *arch* directory.
If the directory structure before executing the command looked like this:

```text
my_dir/
+-- doc/
|  +-- MANUAL.md
|  +-- ref/
|     +-- links.md
+-- arch/
|  +-- ARCH.md 
+-- README.md
```

After the copy it will become:

```text
my_dir/
+-- doc/
|  +-- MANUAL.md
|  +-- ref/
|     +-- links.md
+-- arch/
|  +-- doc/
|     +-- MANUAL.md
|     +-- ref/
|        +-- links.md
|  +-- ARCH.md 
+-- README.md
```

In the command:

```shell
cp -f --recursive ./doc/ ./arch/ 
```

* `cp` is the program's name
* `-f` is an **option** in its short form (its long form is `--force`)
* `--recursive` is an **option** in its long form (its short form is `-R`)
* `./doc/` and `./arch/` are **positional arguments**

Traditionally, options can be specified in long or short forms. 
The short ones are one-character codes prefixed with a *minus sign* `-`.
The long ones are usually very descriptive (e.g.: `--preserve-extended-attributes`) and prefixed with a double *minus sign* `--`.


Options can take additional arguments. 
The command `tar` that creates archives (think something like `zip` or `rar`) from multiple files has an option `--file` to specify the file name of the output file.

The following command creates a new archive with the content of the `./arch/` directory and saves it to *arch.tar* file.
Here `--create` is an ***option*** with no arguments and `--file` is an ***option*** with one argument `arch.tar`. Finally, `./arch/` is a _**positional argument**_.

```shell
tar --create --file arch.tar ./arch/
```

Sometimes options that take arguments are followed by the equality symbol `=`:

```shell
tar --create --file=arch.tar ./arch/
```

Some commands support both styles (like `tar`).

Whether an option should be followed by an argument depends only on how a programmer specified it. Moreover, not providing an argument to an option that requires one is an error:

```shell
# the following line contains an error, --file expects an argument
tar --create --file ./arch/
```

The number of positional arguments (or their absence) also depends on how a program is specified. 
For many commands the positional arguments are linked to the options. 
For instance for some combination of options only one positional argument is needed, while for another three should be provided.

## Receiving arguments in programs

Arguments passed to a program appear as arguments to the `main` function:

```cpp
int main(int argc, char* argv[]);
```

* `argc` is the number of arguments passed to program
* `argv` is an array of `argc` character strings (`char*`), each string corresponding to one argument.

On most systems the first argument is the program's name, consequently `argc` is at least 1.


Assuming that a program is called `my_app` (or `my_app.exe` on Windows) and run as follows:

```shell
./my_app --verbose -l 0.8 --input in.txt
```

The following `main` function of `my_app`:

```c++
#include <iostream>

int main(int args, char* argv[]){
    for (int i=0; i<argc; ++i){
        std::cout << i << ": " << argv[i] << '\n';
    }
}
```

would print:

```text
0: ./my_app
1: --verbose
2: -l
3: 0.8
4: --input
5: in.txt
```

As you can see, arguments are split on white spaces by the system that, subsequently, forwards them to the program.

## `lib_args`

`lib_args` is a library that *attempts* to simplify the way *command line arguments* are parsed and accepted by programs.
The code below shows its example usage:

```c++
int main(int argc, char *argv[]) {

    // lib_arg accepts a whole string instead of an array of arguments
    // here this string is created by concatenating arguments
    std::ostringstream oss{};
    for (int arg_no = 0; arg_no < argc; ++ arg_no){
        oss << argv[arg_no] << ' ';
    }

    // this creates a set of options to be recognized by lib_argc for this program
    // the format for this is:
    // {short_option_form, long_option_form, does_option_need_an_argument, what_kind_of_argument_it_needs}
    // there are only three argument kinds accepted by options: text, int or float
    add_option({'v', "verbose", "prints verbose diagnostics", false, pt_none});
    add_option({'l', "level", "sets compression level (0.0-1.0)", true, pt_float});
    add_option({'i', "input", "input file name", true, pt_text});
    add_option({'o', "output", "output file name", true, pt_text});
    add_option({'s', "size", "dictionary size in kb (1-1000)", true, pt_int});

    // parse the arguments passed to the program using the configuration set-up with `add_option`
    // the results of this call is a vector of `argument` struct's 
    // each such a struct contains the <long option form> and the parsed option argument, if any 
    auto arguments = get_parser().parse(oss.str());

    // pass the parsed arguments to the program class and run it
    program prog{arguments};
    prog.run();
```

`lib_arg` is terribly written (just look at the code). 
It works by sheer luck and brute force. 
Your task is to fix it by applying object-oriented design principles and patterns.

## What to do?

First, read and **understand** how the current implementation works. It's not really that difficult.
The only function that does anything substantial is `option_parser::parse`.

The code is a bad mix of programming styles and paradigms. 
The greatest offence is, most likely, committed by three *free functions* (`add_option`, `print_help`, `remove_option`) that are `friend`s of `option_parser`.
All three functions operate on a `static` instance of `option_parser` that's defined in the source file *lib_args.cpp* and hidden from a user.

Other grand offences are:

* not using inheritance and a common interface for `option`, different types of options (argument-less, int, text and float) should be separate classes with a common interface

* not using an interface for `option_parser`

* not clearly separating responsibilities, `option_parser` should be only parsing not also adding/ removing options

* not using an interface and a concrete implementation for a collection of parsed options (the one that `option_parser::parse` returns) - now it's just a vector of `argument`'s

* not injecting such a concrete collection of arguments into `program` through an interface

* clearly redundant concatenating of command-line arguments into a string before parsing them (just why?)

* a forced, ugly way of creating an `option_parser` object

* using `enum` instead of `enum class`

* unnecessary field in `struct option` (`accepts_parameter` - field `pt` already contains the same information)

... and possibly many more.

After you feel comfortable with the current implementation and have played with it for a while, change it.

### The bare minimum (to get 0-14 points total)

* Use interfaces - each concrete class that you have should implement an interface (or inherit from an abstract class).

* Get rid of `friend` functions - they should belong to `option_parser`

* Get rid of the weird hidden `option_parser` instance in the source file, there's nothing wrong with having multiple `option_parser` objects and letting a client create them.

* Make different options into separate classes implementing a common interface / extending a common abstract class.
    * `flag_option` (that's the one with no arguments), `int_option`, `dbl_option` and `text_option` inheriting from `option` might be an idea
    * The concrete option classes should ideally be responsible for parsing their own arguments (if they accept any).
    * You'll most likely get rid of the ugly `enum` while working on this point.

* Try to use an interface and a concrete class for parsed arguments instead of `std::vector<argument>`
    * `argument` class is a very bad design - all those fields (`int_value`, `str_value`, `dbl_value`) shouldn't be there.
    * Again, a good idea would be to have an abstract class and different concrete argument classes that inherit from it and contain only the needed fields (e.g. `int_argument` that has an `int m_value` field)

### The middle ground (to get 14-17 points total)

Same as above and additionally:

*  Allow for creating `option_parser` (together with all the options) with a *builder*, like this:


    ```c++
    auto op = option_parser_builder()
                  .with_option('v', "verbose", "prints verbose diagnostics")
                  .with_int_option('l', "level", "normalized output level")
                  .with_dbl_option('f', "filter", "low-pass filter frequency")
                  .with_text_option('p', "profile", "additional amplifier frequency profile file name")
                  .make();
    ```

* Make `option_parser` work with some kind of a collection of command-line arguments as an input, not a single concatenated text line.

* `option_parser` mustn't be responsible for adding/ removing options - delegate this task to another class and pass its instance to `option_parser`

* Add support for range-checking of numerical arguments of options. For instance an `option_parser` created with:

    ```c++
    auto op = option_parser_builder()
                    .with_int_option('l', "level", "normalized output level", {1, 20}).
                    make();
        
    ```

    should be fine with:

    ```shell
    ./my_app --level 18
    ```

    but complain and show an error message with:

    ```shell
    ./my_app --level 108
    ```

* Add the possibility to configure the `help` option flags in `lib_arg`. Now only `-h` and `--help` are supported by default. These flags should be configurable by a programmer.

### The grand design (to get 17-20 points total)

Same as above and additionally:

* Wrap the arguments passed to the program in some class. Expose a singleton instance of this class in your program. It should provide read-only access to arguments:

    ```c++
    int main(int argc, char* argv[]){
        arguments::initialize(argc, argv);
        
        // ...
        
        std::unique_ptr<option_parser> op = ...;
        
        op.parse(arguments::get());
    }
    ```

* Add support for *positional_arguments* to `option_parser` and its builder, perhaps like this:

    ```c++
    auto op = option_parser_builder()
                    .with_int_option('l', "level", "normalized output level", {1, 20}).
                    .with_text_positional("output")
                    .make();
    ```

    ```shell
    ./my_app --help

    my_app [flags] <OUTPUT>

    <OUTPUT>        output file name

    flags:
    -h, --help      prints this help message
    -l, --level     normalized output level (integer in range 1-20)
    ```

* Add support for default argument values. Each argument that a programmer of `lib_arg` configures should have a default value. If a program is invoked without some flag, the corresponding option should be added anyway to the parsing output with its default value.


    ```c++
    auto op = option_parser_builder()
                    .with_int_option('l', "level", "normalized output level", {1, 20}, 5).
                    .with_text_positional("output", stdout)
                    .with_option('v', "verbose", "verbose output", false)
                    .make();
    ```

    ```shell
    ./my_app --help

    my_app [flags] <OUTPUT>

    <OUTPUT>        output file name (default: stdout)

    flags:
    -h, --help      prints this help message
    -l, --level     normalized output level (integer in range 1-20, default: 5)
    -v --verbose    verbose output (default: off)
    ```

    The following command:

    ```shell
    ./my_app --verbose
    ```

    will then result in the following parser output (all the options are included):

    * level:int = 5
    * verbose:bool = true
    * output:string = stdout

