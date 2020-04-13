
cdef extern from "time.h":
    cdef int CLOCK_MONOTONIC
    cdef long int time_t
    cdef int clockid_t

    cdef struct timespec:
        time_t tv_sec
        long int tv_nsec
    
    int clock_gettime(clockid_t clk_id, timespec *res)

cdef class Clock:
    cdef timespec res
    cdef timespec reference

    def __init__(self):
        self.init_counters()
    
    cdef void init_counters(self):
        clock_gettime(CLOCK_MONOTONIC, &self.reference)

    cpdef double get_time(self):
        clock_gettime(CLOCK_MONOTONIC, &self.res)
        return (self.res.tv_sec - self.reference.tv_sec) +
               (self.res.tv_nsec - self.reference.tv_nsec) * 1e-9
