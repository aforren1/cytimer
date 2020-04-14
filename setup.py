from setuptools import setup
from Cython.Build import cythonize
from setuptools.extension import Extension
from sys import platform

if platform == 'win32':
    src = ['winclock.pyx']
    libs = ['kernel32']
elif platform == 'darwin':
    src = ['macclock.pyx']
    libs = ['c']
elif platform == 'linux':
    src = ['linuxclock.pyx']
    libs = ['c']

extensions = [
    Extension('cytimer', src, libraries=libs,
              language='c++',
              extra_compile_args=['-std=c++03'])
]

setup(
    ext_modules = cythonize(extensions, 
                            compiler_directives={'language_level' : "3"})
)
