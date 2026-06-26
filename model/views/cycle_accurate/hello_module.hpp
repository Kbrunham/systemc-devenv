#pragma once

#include <iostream>
#include <systemc>

using namespace sc_core;

SC_MODULE(hello_module)
{
    sc_out<bool> done;

    void run()
    {
        std::cout << "Hello SystemC!" << std::endl;
        done.write(true);
        sc_stop();
    }

    SC_CTOR(hello_module) : done("done")
    {
        SC_THREAD(run);
    }
};
