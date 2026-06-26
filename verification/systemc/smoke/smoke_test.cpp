#include <gtest/gtest.h>
#include <systemc>

#include "hello_module.hpp"

TEST(SystemcSmokeTest, HelloModuleRunsAndSignalsDone)
{
    hello_module hello("hello");
    sc_signal<bool> done;
    hello.done(done);

    sc_start();

    EXPECT_TRUE(done.read());
}
