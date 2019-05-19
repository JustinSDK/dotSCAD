> Version numbers are based on [Semantic Versioning](https://semver.org/).

# v1.1.1
- Bugfixes
  - `m_rotation` returns an identity matrix if `a` is 0.
  - The `path_pts` parameter of `path_extrude` accepts two or three points. 
  - The `points` parameter of `along_with` accepts two or three points. 

- Others
  -  OpenSCAD has built-in matrix multiplication so `m_multiply` is not necessary.

# v1.1
- New matrix functions:
  - [m_multiply](https://openhome.cc/eGossip/OpenSCAD/lib-m_multiply.html)
  - [m_cumulate](https://openhome.cc/eGossip/OpenSCAD/lib-m_cumulate.html)
  - [m_translation](https://openhome.cc/eGossip/OpenSCAD/lib-m_translation.html)
  - [m_rotation](https://openhome.cc/eGossip/OpenSCAD/lib-m_rotation.html)
  - [m_scaling](https://openhome.cc/eGossip/OpenSCAD/lib-m_scaling.html)
  - [m_mirror](https://openhome.cc/eGossip/OpenSCAD/lib-m_mirror.html)
  - [m_shearing](https://openhome.cc/eGossip/OpenSCAD/lib-m_shearing.html)

- New modules:
  - [shear](https://openhome.cc/eGossip/OpenSCAD/lib-shear.html)

- New Parameters:
  - added `v` parameter to [rotate_p](https://openhome.cc/eGossip/OpenSCAD/lib-rotate_p.html)


- Improved Performance:
    - [path_extrude](https://openhome.cc/eGossip/OpenSCAD/lib-path_extrude.html)
    - [align_with](https://openhome.cc/eGossip/OpenSCAD/lib-along_with.html)  

# v1.0.1
- Fixed `path_extrude` crossing problem. See [issue 3](https://github.com/JustinSDK/dotSCAD/issues/3).
- Fixed `along_with` crossing problems (similar to `path_extrude`.)

# v1.0
- First release.