# Compiling and Running Simulations

### SystemC Compilation
- C++ class library
    - Build simulation executuable with a C compiler
- GNU C compiler (gcc)
    - Found on most any workstation
    - `which gcc`

#### `gcc` needs:
- Executable name
    - `-o` switch
- List of source files (*.cc)
- Include directories
    - Location of design source
    - Location of SystemC source
    - `-I` switch
- Library directory 
    - Location of SystemC archive
    - `-L` switch
- Libraries to link
    - SystemC, standard C++ and math

### Command line
```sh
gcc 
    -o main 
    main.cc fir.cc tb.cc
    -I.
    -I$SYSTEMC/include
    -L$SYSTEMC/lib-linux64
    -lsystemc # linking systemc
    -lstdc++  # c++
    -lm       # math

gcc -o main main.cc fir.cc tb.cc -I. -I$SYSTEMC/include -L$SYSTEMC/lib-linux64 -lsystemc -lstdc++ -lm
```

