
# cdef extern from "Windows.h" nogil:
#     pass

cdef extern from "Windows.h":

    ctypedef long BOOL

    ctypedef union LARGE_INTEGER:
        long long QuadPart
    
    BOOL QueryPerformanceFrequency(LARGE_INTEGER* lpFrequency)
    BOOL QueryPerformanceCounter(LARGE_INTEGER* lpPerformanceCount)

cdef class Clock:
    cdef LARGE_INTEGER reference
    cdef double inv_freq
    cdef LARGE_INTEGER res
    
    def __init__(self):
        self.init_counters()

    cdef void init_counters(self):
        cdef LARGE_INTEGER frequency
        QueryPerformanceFrequency(&frequency)
        QueryPerformanceCounter(&self.reference)
        self.inv_freq = 1.0/frequency.QuadPart

    cpdef double get_time(self):
        QueryPerformanceCounter(&self.res)
        self.res.QuadPart -= self.reference.QuadPart
        return self.res.QuadPart * self.inv_freq

# just testing whether the C equivalent is called (it is!)      
# cdef class Wrapper:
#     cdef Clock clock

#     def __init__(self, Clock clock):
#         self.clock = clock
    
#     cdef double _use_time(self):
#         cdef double res = self.clock.time()
#         return res
    
#     def foo(self):
#         res = self._use_time()
#         return res*2
