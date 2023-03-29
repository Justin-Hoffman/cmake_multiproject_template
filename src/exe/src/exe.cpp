#include <iostream>
#include "libA/A.h"
#include "libB/B.h"
#include "exe/exe.h"


void print_hello_world(){
    print_hello();
    std::cout << " ";
    print_world();
    std::cout << std::endl;
}
