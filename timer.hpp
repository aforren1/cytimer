#include <chrono>

using std::chrono::duration_cast;
using std::chrono::nanoseconds;
using std::chrono::steady_clock;
using std::chrono::time_point;

namespace mycpp
{

class MonoClock
{
public:
    MonoClock()
    {
        reset_time = clock.now();
    }
    MonoClock(const bool relative, const long long ns = -1)
    {
        if (ns > -1)
        {
            reset_time = steady_clock::time_point() + nanoseconds(ns);
        }

        else
        {
            reset_time = steady_clock::time_point();
            if (relative)
            {
                reset_time = clock.now();
            }
        }
    }

    ~MonoClock() {}
    inline long long get_time_ns()
    {
        return duration_cast<nanoseconds>(clock.now() - reset_time).count();
    }
    inline double get_time()
    {
        return static_cast<double>(get_time_ns()) / 1000000000.0;
    }

    inline long long dump_origin_ns()
    {
        return duration_cast<nanoseconds>(reset_time.time_since_epoch()).count();
    }

private:
    steady_clock clock;
    std::chrono::steady_clock::time_point reset_time;
};
} // namespace mycpp
