
cdef extern from "<time.h>":
    ctypedef long time_t
    ctypedef int clockid_t

    ctypedef struct timespec:
        time_t tv_sec
        long tv_nsec

    int clock_gettime(clockid_t clk_id, timespec* tp)
    cdef clockid_t CLOCK_MONOTONIC


cdef class Clock:
    cdef timespec res
    cdef timespec reference

    def __init__(self):
        self.init_counters()
    
    cdef void init_counters(self):
        clock_gettime(CLOCK_MONOTONIC, &self.reference)

    cpdef double get_time(self):
        clock_gettime(CLOCK_MONOTONIC, &self.res)
        return (self.res.tv_sec - self.reference.tv_sec) + \
               (self.res.tv_nsec - self.reference.tv_nsec) * 1e-9
