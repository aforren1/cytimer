#include <type_traits>
#include <chrono>

using std::chrono::nanoseconds;
using std::chrono::steady_clock;

namespace mycpp {

class MonoClock
{
public:
    MonoClock(const bool relative = true)
    {
        reset_time = std::chrono::time_point<steady_clock, nanoseconds>::time_point();
        if (relative)
        {
            reset_time = clock.now();
        }
    }

    ~MonoClock() {}
    inline long long elapsed_ns()
    {
        return std::chrono::duration_cast<nanoseconds>(clock.now() - reset_time).count();
    }
    inline double get_time()
    {
        return static_cast<double>(elapsed_ns()) / 1'000'000'000.0;
    }

private:
    std::chrono::steady_clock clock;
    std::chrono::steady_clock::time_point reset_time;
};
}
