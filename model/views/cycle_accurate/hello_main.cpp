#include "hello_module.hpp"

int sc_main(int argc, char *argv[])
{
    hello_module hello("hello");
    sc_signal<bool> done;
    hello.done(done);

    sc_start();
    return 0;
}
