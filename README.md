
This provides a wrapper around the marching cubes ver 33 C code as implemented by Vega, et al
(https://github.com/dvega68/MC33_c_library)

The algorithm assumes a grid with linear storage where the X grid coordinate changes fastest, Z slowest.

Using in your Swift code requires dealing with unsafe pointers in order to interface with C. The
code SwiftMC33LibTests.swift under the Tests directory in the repo gives a concrete example taken
from the original repo of Vega. The test function is testSurface(), it produces an isosurface in 
wavefront .obj format which you can check in MeshLab or other tool capable of reading this format.

There are some minor modifications of the original C code.

R. Zauhar, PhD
6 June 2024


 
