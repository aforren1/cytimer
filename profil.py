from mglg.util import timethat

n = 1e6
timethat('gt()', setup='from cytimer import Clock;x=Clock();gt=x.get_time', number=n)
timethat('default_timer()', setup='from timeit import default_timer', number=n)
timethat('GetSecs()', setup='from psychtoolbox import GetSecs;GetSecs()', number=n)
timethat('gt()', setup='from toon.util import mono_clock;gt=mono_clock.get_time', number=n)
