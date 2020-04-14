# from https://github.com/scikit-learn/scikit-learn/pull/2426#issuecomment-24366848
cdef extern from "mach/mach.h":
    pass

cdef extern from "mach/mach_time.h":
    ctypedef unsigned long uint64_t
    uint64_t mach_absolute_time()

    ctypedef struct mach_timebase_info_data_t:
        uint64_t numer
        uint64_t denom
    
    void mach_timebase_info(mach_timebase_info_data_t*)

cdef class Clock:
    cdef uint64_t reference
    cdef double inv_freq
    cdef uint64_t res

    def __init__(self):
        self.init_counters()
    
    cdef void init_counters(self):
        self.reference = mach_absolute_time()
        cdef mach_timebase_info_data_t base
        mach_timebase_info(&base)
        self.inv_freq = 1.0/(<double>base.numer / base.denom * 1.0e9)

    cpdef double get_time(self):
        self.res = mach_absolute_time()
        self.res -= self.reference
        return self.res * self.inv_freq
