from libcpp cimport bool

cdef extern from "timer.hpp" namespace "mycpp":
    cdef cppclass CMonoClock "mycpp::MonoClock":
        CMonoClock() except +
        CMonoClock(const bool relative, const long long ns) except +
        long long get_time_ns()
        double get_time()
        long long dump_origin_ns()

cdef class MonoClock:
    cdef CMonoClock cclk
    def __cinit__(self, const bool relative=True, ns=-1):
        self.cclk = CMonoClock(relative, ns)
    cpdef get_time_ns(self):
        return self.cclk.get_time_ns()
    cpdef get_time(self):
        return self.cclk.get_time()
    cpdef getTime(self):
        return self.cclk.get_time()
    cpdef dump_origin_ns(self):
        return self.cclk.dump_origin_ns()
    def __reduce__(self):
        return (MonoClock, (True, self.dump_origin_ns()))


mono_clock = MonoClock.__new__(MonoClock)
