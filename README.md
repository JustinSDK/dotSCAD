# dotSCAD

> These fundamental modules and functions are helpful when playing OpenSCAD.

[![license/LGPL](https://img.shields.io/badge/license-LGPL-blue.svg)](https://github.com/JustinSDK/lib-openscad/blob/master/LICENSE)

## Introduction

Every module or function is located in the file which has the same name as the module or the function. For examples, if you want to use the `line2d` module to draw a line, `include <line2d.scad>` first. 

	include <line2d.scad>;

	line2d(p1 = [0, 0], p2 = [5, 0], width = 1);

Some modules may depend on other modules. For example, the `polyline2d` module depends on the `line2d` module, so you also have to `include <line2d.scad>` besides `include <polyline3d.scad>`. 

	include <line2d.scad>;
	include <polyline3d.scad>;

	polyline2d(points = [[1, 2], [-5, -4], [-5, 3], [5, 5]], width = 1);

## Documentation

- 2D
	- [line2d](https://openhome.cc/eGossip/OpenSCAD/lib-line2d.html)
	- [polyline2d](https://openhome.cc/eGossip/OpenSCAD/lib-polyline2d.html)
	- [circular_sector](https://openhome.cc/eGossip/OpenSCAD/lib-circular_sector.html)
	- [arc](https://openhome.cc/eGossip/OpenSCAD/lib-arc.html)

- 3D
	- [line3d](https://openhome.cc/eGossip/OpenSCAD/lib-line3d.html)
	- [polyline3d](https://openhome.cc/eGossip/OpenSCAD/lib-polyline3d.html)
	- [hull_polyline3d](https://openhome.cc/eGossip/OpenSCAD/lib-hull_polyline3d.html)

- Transformation
	- [hollow_out](https://openhome.cc/eGossip/OpenSCAD/lib-hollow_out.html)
	- [bend](https://openhome.cc/eGossip/OpenSCAD/lib-bend.html)

- Path
    - [circle_path](https://openhome.cc/eGossip/OpenSCAD/lib-circle_path.html)
    - [bezier](https://openhome.cc/eGossip/OpenSCAD/lib-bezier.html)
    - [cylinder_spiral](https://openhome.cc/eGossip/OpenSCAD/lib-cylinder_spiral.html)
    - [archimedean_spiral](https://openhome.cc/eGossip/OpenSCAD/lib-archimedean_spiral.html)

- Other
    - [box_extrude](https://openhome.cc/eGossip/OpenSCAD/lib-box_extrude.html)
    - [stereographic_extrude](https://openhome.cc/eGossip/OpenSCAD/lib-stereographic_extrude.html)

## About dotSCAD

I've been using OpenSCAD for years and created some funny things. Some of them include several important ideas and details. To prevent forgetfulness, I decided to [write them down](https://openhome.cc/eGossip/OpenSCAD/). Some examples developed in the documentation are useful so I elaborate them into this library.