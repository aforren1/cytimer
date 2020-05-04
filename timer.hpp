#include <chrono>

using std::chrono::nanoseconds;
using std::chrono::steady_clock;
using std::chrono::time_point;

namespace mycpp {

class MonoClock
{
public:
    MonoClock() {
        reset_time = steady_clock::time_point();
    }
    MonoClock(const bool relative)
    {
        reset_time = steady_clock::time_point();
        if (relative)
        {
            reset_time = clock.now();
        }
    }

    ~MonoClock() {}
    inline long long get_time_ns()
    {
        return std::chrono::duration_cast<nanoseconds>(clock.now() - reset_time).count();
    }
    inline double get_time()
    {
        return static_cast<double>(get_time_ns()) / 1000000000.0;
    }

private:
    steady_clock clock;
    std::chrono::steady_clock::time_point reset_time;
};
}
