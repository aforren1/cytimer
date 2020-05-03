from setuptools import setup
from Cython.Build import cythonize
from setuptools.extension import Extension
from sys import platform

eca = []
if platform == 'win32':
    eca.append('/std:c++17') # we mostly want to avoid MSVC 2012?

ext = Extension(
    'cytimer',
    ['cytimer.pyx'],
    language='c++',
    libraries=[],
    extra_compile_args=eca,
    extra_link_args=[]
)

setup(
    name = 'cytimer',
    version='0.0.1',
    ext_modules=cythonize(ext, language_level='3', annotate=True)
)
