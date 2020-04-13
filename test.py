
from timeit import timeit
from cytimer import Clock

x = Clock()
t0 = x.get_time()
print(t0, x.get_time() - t0)
n = 1000000
print(timeit('x.get_time()', setup='from cytimer import Clock;x=Clock()',number=n)/n)
print(timeit('default_timer()', setup='from timeit import default_timer', number=n)/n)
