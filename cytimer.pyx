from libcpp cimport bool

cdef extern from "timer.hpp" namespace "mycpp":
    cdef cppclass CMonoClock "mycpp::MonoClock":
        CMonoClock(const bool relative)
        long long elapsed_ns()
        double get_time()

cdef class MonoClock:
    cdef CMonoClock *ptr
    def __cinit__(self, bool relative=True):
        self.ptr = new CMonoClock(relative)
    def __dealloc__(self):
        del self.ptr
    cpdef elapsed_ns(self):
        return self.ptr.elapsed_ns()
    cpdef get_time(self):
        return self.ptr.get_time()
    cpdef getTime(self):
        return self.ptr.get_time()
