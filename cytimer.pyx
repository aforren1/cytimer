from libcpp cimport bool

cdef extern from "timer.hpp" namespace "mycpp":
    cdef cppclass CMonoClock "mycpp::MonoClock":
        CMonoClock() except +
        CMonoClock(const bool relative) except +
        long long get_time_ns()
        double get_time()

cdef class MonoClock:
    cdef CMonoClock cclk
    def __cinit__(self, const bool relative=True):
        self.cclk = CMonoClock(relative)
    cpdef get_time_ns(self):
        return self.cclk.get_time_ns()
    cpdef get_time(self):
        return self.cclk.get_time()
    cpdef getTime(self):
        return self.cclk.get_time()

mono_clock = MonoClock.__new__(MonoClock)
