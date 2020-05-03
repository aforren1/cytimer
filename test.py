
from timeit import timeit
from cytimer import MonoClock

x = MonoClock()
t0 = x.get_time()
print(t0, x.get_time() - t0)
n = 1000000
print(timeit('x.get_time()', setup='from cytimer import MonoClock;x=MonoClock()',number=n)/n)
# print(timeit('x.get_time()', setup='from toon.util import mono_clock as x', number=n)/n)
print(timeit('default_timer()', setup='from timeit import default_timer', number=n)/n)
