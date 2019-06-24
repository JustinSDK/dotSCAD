# dotSCAD 2 (beta)

> **Reduce the burden of 3D modeling in mathematics. Based on OpenSCAD 2019.05.**

![dotSCAD](WhirlingTaiwan.JPG)

[![license/LGPL](https://img.shields.io/badge/license-LGPL-blue.svg)](https://github.com/JustinSDK/lib-openscad/blob/master/LICENSE)

## Introduction

OpenSCAD uses three library locations, the installation library, built-in library, and user defined libraries. It's convenient to set `OPENSCADPATH`. Check [Setting OPENSCADPATH](https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/Libraries#Setting_OPENSCADPATH) in [OpenSCAD User Manual/Libraries](https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/Libraries) for details.

Every module or function is located in the file which has the same name as the module or the function. For example, if you want to use the `line2d` module to draw a line, `include <line2d.scad>;` first. 

	include <line2d.scad>;

	line2d(p1 = [0, 0], p2 = [5, 0], width = 1);

Some module files are organized in a directory. For example, px_circle.scad exists in `pixel` directory. You have to prefix the directory name when including `px_circle`.

    include <pixel/px_circle.scad>;
	points = px_circle(radius = 10);
	for(pt = points) {
        translate(pt) square(1);
	}

## Dependencies

Some modules depend on other modules. For example, the `polyline2d` module depends on the `line2d` module, so you also have to `include <line2d.scad>;` besides `include <polyline3d.scad>;`. 

	include <line2d.scad>;
	include <polyline3d.scad>;

	polyline2d(points = [[1, 2], [-5, -4], [-5, 3], [5, 5]], width = 1);

If OpenSCAD generates "WARNING: Ignoring unknown xxx function" or "WARNING: Ignoring unknown xxx module" when using one module of dotSCAD. Just try to `include <xxx.scad>;` or `include <dir/xxx.scad>` if xxx.scad exists in `dir` directory.

Too many dependencies? Because OpenSCAD doesn't provide namespace management, I personally think that exposing dependencies is better than hiding them. In this way, users can have their own way to manage dependencies. How to categorize dependencies is up to you. For example, you can include your commonly-used modules and functions in "commonly_used.scad" and then `include <commonly_used.scad>;` in the ".scad" file of your project.

**If you really don't want to care about dependencies, `include <dotSCAD.scad>;` or `use <dotSCAD.scad>;` come to save you.**

## Documentation

- 2D
    - [arc](https://openhome.cc/eGossip/OpenSCAD/lib-arc.html)
	- [pie](https://openhome.cc/eGossip/OpenSCAD/lib-pie.html)
	- [rounded_square](https://openhome.cc/eGossip/OpenSCAD/lib-rounded_square.html)
	- [line2d](https://openhome.cc/eGossip/OpenSCAD/lib-line2d.html)
	- [polyline2d](https://openhome.cc/eGossip/OpenSCAD/lib-polyline2d.html)
	- [hull_polyline2d](https://openhome.cc/eGossip/OpenSCAD/lib-hull_polyline2d.html)
	- [hexagons](https://openhome.cc/eGossip/OpenSCAD/lib-hexagons.html)
	- [polytransversals](https://openhome.cc/eGossip/OpenSCAD/lib-polytransversals.html)
    - [multi_line_text](https://openhome.cc/eGossip/OpenSCAD/lib-multi_line_text.html)
	- [voronoi2d](https://openhome.cc/eGossip/OpenSCAD/lib-voronoi2d.html)

- 3D
	- [rounded_cube](https://openhome.cc/eGossip/OpenSCAD/lib-rounded_cube.html)
    - [rounded_cylinder](https://openhome.cc/eGossip/OpenSCAD/lib-rounded_cylinder.html)
    - [crystal_ball](https://openhome.cc/eGossip/OpenSCAD/lib-crystal_ball.html)
	- [line3d](https://openhome.cc/eGossip/OpenSCAD/lib-line3d.html)
	- [polyline3d](https://openhome.cc/eGossip/OpenSCAD/lib-polyline3d.html)
	- [hull_polyline3d](https://openhome.cc/eGossip/OpenSCAD/lib-hull_polyline3d.html)
	- [function_grapher](https://openhome.cc/eGossip/OpenSCAD/lib-function_grapher.html)
	- [polysections](https://openhome.cc/eGossip/OpenSCAD/lib-polysections.html)
	- [starburst](https://openhome.cc/eGossip/OpenSCAD/lib-starburst.html)
	- [voronoi3d](https://openhome.cc/eGossip/OpenSCAD/lib-voronoi3d.html)
	
- Transformation
    - [along_with](https://openhome.cc/eGossip/OpenSCAD/lib-along_with.html)
	- [hollow_out](https://openhome.cc/eGossip/OpenSCAD/lib-hollow_out.html)
	- [bend](https://openhome.cc/eGossip/OpenSCAD/lib-bend.html)
	- [shear](https://openhome.cc/eGossip/OpenSCAD/lib-shear.html)

- Functon
	- [rotate_p](https://openhome.cc/eGossip/OpenSCAD/lib-rotate_p.html)
	- [cross_sections](https://openhome.cc/eGossip/OpenSCAD/lib-cross_sections.html)
	- [paths2sections](https://openhome.cc/eGossip/OpenSCAD/lib-paths2sections.html)
	- [path_scaling_sections](https://openhome.cc/eGossip/OpenSCAD/lib2-path_scaling_sections.html)
	- [bijection_offset](https://openhome.cc/eGossip/OpenSCAD/lib-bijection_offset.html)
	- [in_polyline](https://openhome.cc/eGossip/OpenSCAD/lib-in_polyline.html)
	- [in_shape](https://openhome.cc/eGossip/OpenSCAD/lib-in_shape.html)
	- [midpt_smooth](https://openhome.cc/eGossip/OpenSCAD/lib-midpt_smooth.html)
	- [trim_shape](https://openhome.cc/eGossip/OpenSCAD/lib-trim_shape.html)
	- [triangulate](https://openhome.cc/eGossip/OpenSCAD/lib-triangulate.html)
	
- Path
    - [arc_path](https://openhome.cc/eGossip/OpenSCAD/lib-arc_path.html)
	- [circle_path](https://openhome.cc/eGossip/OpenSCAD/lib-circle_path.html)
    - [bezier_curve](https://openhome.cc/eGossip/OpenSCAD/lib-bezier_curve.html)
	- [bezier_surface](https://openhome.cc/eGossip/OpenSCAD/lib-bezier_surface.html)
	- [bezier_smooth](https://openhome.cc/eGossip/OpenSCAD/lib-bezier_smooth.html)
    - [helix](https://openhome.cc/eGossip/OpenSCAD/lib-helix.html)
    - [golden_spiral](https://openhome.cc/eGossip/OpenSCAD/lib-golden_spiral.html)
    - [archimedean_spiral](https://openhome.cc/eGossip/OpenSCAD/lib-archimedean_spiral.html)
    - [sphere_spiral](https://openhome.cc/eGossip/OpenSCAD/lib-sphere_spiral.html)
	- [torus_knot](https://openhome.cc/eGossip/OpenSCAD/lib-torus_knot.html)

- Extrusion
    - [box_extrude](https://openhome.cc/eGossip/OpenSCAD/lib-box_extrude.html)
	- [ellipse_extrude](https://openhome.cc/eGossip/OpenSCAD/lib-ellipse_extrude.html)
    - [stereographic_extrude](https://openhome.cc/eGossip/OpenSCAD/lib-stereographic_extrude.html)
	- [rounded_extrude](https://openhome.cc/eGossip/OpenSCAD/lib-rounded_extrude.html)

- 2D Shape
    - [shape_taiwan](https://openhome.cc/eGossip/OpenSCAD/lib-shape_taiwan.html)
	- [shape_arc](https://openhome.cc/eGossip/OpenSCAD/lib-shape_arc.html)
	- [shape_pie](https://openhome.cc/eGossip/OpenSCAD/lib-shape_pie.html)
	- [shape_ellipse](https://openhome.cc/eGossip/OpenSCAD/lib-shape_ellipse.html)
    - [shape_square](https://openhome.cc/eGossip/OpenSCAD/lib-shape_square.html)
	- [shape_trapezium](https://openhome.cc/eGossip/OpenSCAD/lib-shape_trapezium.html)
	- [shape_cyclicpolygon](https://openhome.cc/eGossip/OpenSCAD/lib-shape_cyclicpolygon.html)
    - [shape_pentagram](https://openhome.cc/eGossip/OpenSCAD/lib-shape_pentagram.html)	
    - [shape_starburst](https://openhome.cc/eGossip/OpenSCAD/lib-shape_starburst.html)	    
	- [shape_superformula](https://openhome.cc/eGossip/OpenSCAD/lib-shape_superformula.html)
	- [shape_glued2circles](https://openhome.cc/eGossip/OpenSCAD/lib-shape_glued2circles.html)
	- [shape_path_extend](https://openhome.cc/eGossip/OpenSCAD/lib-shape_path_extend.html)		

- 2D Shape Extrusion
	- [bend_extrude](https://openhome.cc/eGossip/OpenSCAD/lib-bend_extrude.html)
	- [path_extrude](https://openhome.cc/eGossip/OpenSCAD/lib-path_extrude.html)
	- [ring_extrude](https://openhome.cc/eGossip/OpenSCAD/lib-ring_extrude.html)
	- [helix_extrude](https://openhome.cc/eGossip/OpenSCAD/lib-helix_extrude.html)
	- [golden_spiral_extrude](https://openhome.cc/eGossip/OpenSCAD/lib-golden_spiral_extrude.html)
	- [archimedean_spiral_extrude](https://openhome.cc/eGossip/OpenSCAD/lib-archimedean_spiral_extrude.html)
	- [sphere_spiral_extrude](https://openhome.cc/eGossip/OpenSCAD/lib-sphere_spiral_extrude.html)

- Utilities
	- [util/sub_str](https://openhome.cc/eGossip/OpenSCAD/lib2-sub_str.html)
	- [util/split_str](https://openhome.cc/eGossip/OpenSCAD/lib2-split_str.html)
	- [util/parse_number](https://openhome.cc/eGossip/OpenSCAD/lib2-parse_number.html)
    - util/reverse
	- util/slice

- Matrix
	- [matrix/m_cumulate](https://openhome.cc/eGossip/OpenSCAD/lib2-m_cumulate.html)	
	- [matrix/m_translation](https://openhome.cc/eGossip/OpenSCAD/lib2-m_translation.html)
	- [matrix/m_rotation](https://openhome.cc/eGossip/OpenSCAD/lib2-m_rotation.html)
	- [matrix/m_scaling](https://openhome.cc/eGossip/OpenSCAD/lib2-m_scaling.html)
	- [matrix/m_mirror](https://openhome.cc/eGossip/OpenSCAD/lib2-m_mirror.html)
	- [matrix/m_shearing](https://openhome.cc/eGossip/OpenSCAD/lib2-m_shearing.html)

- Turtle
    - [turtle/turtle2d](https://openhome.cc/eGossip/OpenSCAD/lib2-turtle2d.html)
    - [turtle/turtle3d](https://openhome.cc/eGossip/OpenSCAD/lib2-turtle3d.html)

- Pixel
    - pixel/px_line
	- pixel/px_polyline
	- pixel/px_circle
	- pixel/px_cylinder
	- pixel/px_sphere
	
## Bugs and Feedback

For bugs, questions and discussions please use the [Github Issues](https://github.com/JustinSDK/dotSCAD/issues).

## About dotSCAD

I've been using OpenSCAD for years and created some funny things. Some of them include several important ideas and details. To prevent forgetfulness, I decided to [write them down](https://openhome.cc/eGossip/OpenSCAD/). Some examples developed in the documentation are useful so I elaborate them into this library.

The idea of the name dotSCAD comes from the filename extension ".scad" of OpenSCAD. 