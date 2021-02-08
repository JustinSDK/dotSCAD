# dotSCAD 3.0 Dev

> **Reduce the burden of mathematics/algorithm when playing OpenSCAD.**

![dotSCAD](featured_img/RandomCityTaiwan.JPG)

[![license/LGPL](LICENSE.svg)](https://github.com/JustinSDK/lib-openscad/blob/master/LICENSE)

## Introduction

**This library requires OpenSCAD 2021.01 or later.** 

Some of my [3D models](https://github.com/JustinSDK/dotSCAD#examples) require complex mathematics/algorithm. I extract them into dotSCAD. Hope it helps when you're playing OpenSCAD.

The idea of the name dotSCAD comes from the filename extension ".scad" of OpenSCAD. 

## Get Started

OpenSCAD uses three library locations, the installation library, built-in library, and user defined libraries. It's convenient to set `OPENSCADPATH`. Check [Setting OPENSCADPATH](https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/Libraries#Setting_OPENSCADPATH) in [OpenSCAD User Manual/Libraries](https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/Libraries) for details.

**I set `OPENSCADPATH` to the `src` folder of dotSCAD so all examples here start searching modules or functions from `src`.**

Every module or function is located in the file which has the same name as the module or the function. For example, if you want to use the `line2d` module to draw a line, `use <line2d.scad>;` first. 

	use <line2d.scad>;

	line2d(p1 = [0, 0], p2 = [5, 0], width = 1);

Some module files are organized in a directory. For example, px_circle.scad exists in `pixel` directory. You have to prefix the directory name when including `px_circle`.

    use <voxel/vx_circle.scad>;
	
	points = vx_circle(radius = 10);
	for(pt = points) {
        translate(pt) square(1);
	}

## Examples

These examples incubate dotSCAD and dotSCAD refactors these examples. See [examples](examples#dogfooding-examples).

[![examples](examples/images/gallery.JPG)](examples#dogfooding-examples)

## Documentation

### 2D Module
- [arc](https://openhome.cc/eGossip/OpenSCAD/lib2x-arc.html)
- [hexagons](https://openhome.cc/eGossip/OpenSCAD/lib2x-hexagons.html)
- [hull_polyline2d](https://openhome.cc/eGossip/OpenSCAD/lib2x-hull_polyline2d.html)
- [line2d](https://openhome.cc/eGossip/OpenSCAD/lib2x-line2d.html)
- [multi_line_text](https://openhome.cc/eGossip/OpenSCAD/lib2x-multi_line_text.html)
- [pie](https://openhome.cc/eGossip/OpenSCAD/lib2x-pie.html)
- [polyline2d](https://openhome.cc/eGossip/OpenSCAD/lib2x-polyline2d.html)
- [polygon_hull](https://openhome.cc/eGossip/OpenSCAD/lib2x-polygon_hull.html)
- [rounded_square](https://openhome.cc/eGossip/OpenSCAD/lib2x-rounded_square.html)

### 3D Module
- [crystal_ball](https://openhome.cc/eGossip/OpenSCAD/lib2x-crystal_ball.html)
- [function_grapher](https://openhome.cc/eGossip/OpenSCAD/lib2x-function_grapher.html)
- [hull_polyline3d](https://openhome.cc/eGossip/OpenSCAD/lib2x-hull_polyline3d.html)
- [line3d](https://openhome.cc/eGossip/OpenSCAD/lib2x-line3d.html)
- [loft](https://openhome.cc/eGossip/OpenSCAD/lib2x-loft.html)
- [polyhedron_hull](https://openhome.cc/eGossip/OpenSCAD/lib2x-polyhedron_hull.html)
- [polyline3d](https://openhome.cc/eGossip/OpenSCAD/lib2x-polyline3d.html)
- [rounded_cube](https://openhome.cc/eGossip/OpenSCAD/lib2x-rounded_cube.html)
- [rounded_cylinder](https://openhome.cc/eGossip/OpenSCAD/lib2x-rounded_cylinder.html)
- [starburst](https://openhome.cc/eGossip/OpenSCAD/lib2x-starburst.html)
- [sweep](https://openhome.cc/eGossip/OpenSCAD/lib2x-sweep.html)

### Transformation
- [along_with](https://openhome.cc/eGossip/OpenSCAD/lib2x-along_with.html)
- [bend](https://openhome.cc/eGossip/OpenSCAD/lib2x-bend.html)
- [hollow_out](https://openhome.cc/eGossip/OpenSCAD/lib2x-hollow_out.html)
- [shear](https://openhome.cc/eGossip/OpenSCAD/lib2x-shear.html)

### 2D Function
- [bijection_offset](https://openhome.cc/eGossip/OpenSCAD/lib2x-bijection_offset.html)
- [contours](https://openhome.cc/eGossip/OpenSCAD/lib2x-contours.html)
- [in_shape](https://openhome.cc/eGossip/OpenSCAD/lib2x-in_shape.html)
- [lines_intersection](https://openhome.cc/eGossip/OpenSCAD/lib2x-lines_intersection.html)	
- [trim_shape](https://openhome.cc/eGossip/OpenSCAD/lib2x-trim_shape.html)
- [triangulate](https://openhome.cc/eGossip/OpenSCAD/lib2x-triangulate.html)

### 2D/3D Function
- [bezier_surface](https://openhome.cc/eGossip/OpenSCAD/lib2x-bezier_surface.html)	
- [bezier_smooth](https://openhome.cc/eGossip/OpenSCAD/lib2x-bezier_smooth.html)	
- [cross_sections](https://openhome.cc/eGossip/OpenSCAD/lib2x-cross_sections.html)
- [in_polyline](https://openhome.cc/eGossip/OpenSCAD/lib2x-in_polyline.html)
- [paths2sections](https://openhome.cc/eGossip/OpenSCAD/lib2x-paths2sections.html)
- [path_scaling_sections](https://openhome.cc/eGossip/OpenSCAD/lib2x-path_scaling_sections.html)
- [midpt_smooth](https://openhome.cc/eGossip/OpenSCAD/lib2x-midpt_smooth.html)

### Path
- [arc_path](https://openhome.cc/eGossip/OpenSCAD/lib2x-arc_path.html)
- [archimedean_spiral](https://openhome.cc/eGossip/OpenSCAD/lib2x-archimedean_spiral.html)
- [bauer_spiral](https://openhome.cc/eGossip/OpenSCAD/lib2x-bauer_spiral.html)
- [bezier_curve](https://openhome.cc/eGossip/OpenSCAD/lib2x-bezier_curve.html)
- [bspline_curve](https://openhome.cc/eGossip/OpenSCAD/lib2x-bspline_curve.html)
- [curve](https://openhome.cc/eGossip/OpenSCAD/lib2x-curve.html)
- [fibonacci_lattice](https://openhome.cc/eGossip/OpenSCAD/lib2x-fibonacci_lattice.html)
- [golden_spiral](https://openhome.cc/eGossip/OpenSCAD/lib2x-golden_spiral.html)
- [helix](https://openhome.cc/eGossip/OpenSCAD/lib2x-helix.html)
- [sphere_spiral](https://openhome.cc/eGossip/OpenSCAD/lib2x-sphere_spiral.html)
- [torus_knot](https://openhome.cc/eGossip/OpenSCAD/lib2x-torus_knot.html)

### Extrusion
- [bend_extrude](https://openhome.cc/eGossip/OpenSCAD/lib2x-bend_extrude.html)	
- [box_extrude](https://openhome.cc/eGossip/OpenSCAD/lib2x-box_extrude.html)
- [ellipse_extrude](https://openhome.cc/eGossip/OpenSCAD/lib2x-ellipse_extrude.html)
- [rounded_extrude](https://openhome.cc/eGossip/OpenSCAD/lib2x-rounded_extrude.html)
- [stereographic_extrude](https://openhome.cc/eGossip/OpenSCAD/lib2x-stereographic_extrude.html)

### 2D Shape
- [shape_arc](https://openhome.cc/eGossip/OpenSCAD/lib2x-shape_arc.html)
- [shape_circle](https://openhome.cc/eGossip/OpenSCAD/lib2x-shape_circle.html)
- [shape_cyclicpolygon](https://openhome.cc/eGossip/OpenSCAD/lib2x-shape_cyclicpolygon.html)
- [shape_ellipse](https://openhome.cc/eGossip/OpenSCAD/lib2x-shape_ellipse.html)
- [shape_liquid_splitting](https://openhome.cc/eGossip/OpenSCAD/lib2x-shape_liquid_splitting.html)
- [shape_path_extend](https://openhome.cc/eGossip/OpenSCAD/lib2x-shape_path_extend.html)
- [shape_pentagram](https://openhome.cc/eGossip/OpenSCAD/lib2x-shape_pentagram.html)
- [shape_pie](https://openhome.cc/eGossip/OpenSCAD/lib2x-shape_pie.html)	
- [shape_square](https://openhome.cc/eGossip/OpenSCAD/lib2x-shape_square.html)
- [shape_starburst](https://openhome.cc/eGossip/OpenSCAD/lib2x-shape_starburst.html)
- [shape_superformula](https://openhome.cc/eGossip/OpenSCAD/lib2x-shape_superformula.html)
- [shape_taiwan](https://openhome.cc/eGossip/OpenSCAD/lib2x-shape_taiwan.html)
- [shape_trapezium](https://openhome.cc/eGossip/OpenSCAD/lib2x-shape_trapezium.html)

### 2D Shape Extrusion
- [archimedean_spiral_extrude](https://openhome.cc/eGossip/OpenSCAD/lib2x-archimedean_spiral_extrude.html)
- [golden_spiral_extrude](https://openhome.cc/eGossip/OpenSCAD/lib2x-golden_spiral_extrude.html)
- [helix_extrude](https://openhome.cc/eGossip/OpenSCAD/lib2x-helix_extrude.html)
- [path_extrude](https://openhome.cc/eGossip/OpenSCAD/lib2x-path_extrude.html)
- [ring_extrude](https://openhome.cc/eGossip/OpenSCAD/lib2x-ring_extrude.html)
- [sphere_spiral_extrude](https://openhome.cc/eGossip/OpenSCAD/lib2x-sphere_spiral_extrude.html)

### Util
- [util/bsearch](https://openhome.cc/eGossip/OpenSCAD/lib3x-bsearch.html)	
- [util/choose](https://openhome.cc/eGossip/OpenSCAD/lib3x-choose.html)
- [util/dedup](https://openhome.cc/eGossip/OpenSCAD/lib3x-dedup.html)
- [util/fibseq](https://openhome.cc/eGossip/OpenSCAD/lib2x-fibseq.html)	
- [util/flat](https://openhome.cc/eGossip/OpenSCAD/lib2x-flat.html)
- [util/has](https://openhome.cc/eGossip/OpenSCAD/lib2x-has.html)
- [util/lerp](https://openhome.cc/eGossip/OpenSCAD/lib2x-lerp.html)
- [util/parse_number](https://openhome.cc/eGossip/OpenSCAD/lib2x-parse_number.html)
- [util/rand](https://openhome.cc/eGossip/OpenSCAD/lib2x-rand.html)
- [util/reverse](https://openhome.cc/eGossip/OpenSCAD/lib2x-reverse.html)
- [util/slice](https://openhome.cc/eGossip/OpenSCAD/lib2x-slice.html)
- [util/sort](https://openhome.cc/eGossip/OpenSCAD/lib3x-sort.html)
- [util/sub_str](https://openhome.cc/eGossip/OpenSCAD/lib2x-sub_str.html)
- [util/split_str](https://openhome.cc/eGossip/OpenSCAD/lib2x-split_str.html)
- [util/sum](https://openhome.cc/eGossip/OpenSCAD/lib2x-sum.html)
- [util/zip](https://openhome.cc/eGossip/OpenSCAD/lib2x-zip.html)

### Matrix
- [matrix/m_cumulate](https://openhome.cc/eGossip/OpenSCAD/lib2x-m_cumulate.html)	
- [matrix/m_determinant](https://openhome.cc/eGossip/OpenSCAD/lib2x-m_determinant.html)
- [matrix/m_mirror](https://openhome.cc/eGossip/OpenSCAD/lib2x-m_mirror.html)
- [matrix/m_rotation](https://openhome.cc/eGossip/OpenSCAD/lib2x-m_rotation.html)
- [matrix/m_scaling](https://openhome.cc/eGossip/OpenSCAD/lib2x-m_scaling.html)
- [matrix/m_shearing](https://openhome.cc/eGossip/OpenSCAD/lib2x-m_shearing.html)
- [matrix/m_translation](https://openhome.cc/eGossip/OpenSCAD/lib2x-m_translation.html)

### Point Transformation
- [ptf/ptf_bend](https://openhome.cc/eGossip/OpenSCAD/lib2x-ptf_bend.html)
- [ptf/ptf_circle](https://openhome.cc/eGossip/OpenSCAD/lib2x-ptf_circle.html)
- [ptf/ptf_ring](https://openhome.cc/eGossip/OpenSCAD/lib2x-ptf_ring.html)
- [ptf/ptf_rotate](https://openhome.cc/eGossip/OpenSCAD/lib2x-ptf_rotate.html)
- [ptf/ptf_sphere](https://openhome.cc/eGossip/OpenSCAD/lib2x-ptf_sphere.html)
- [ptf/ptf_torus](https://openhome.cc/eGossip/OpenSCAD/lib2x-ptf_torus.html)
- [ptf/ptf_x_twist](https://openhome.cc/eGossip/OpenSCAD/lib2x-ptf_x_twist.html)
- [ptf/ptf_y_twist](https://openhome.cc/eGossip/OpenSCAD/lib2x-ptf_y_twist.html)

----

### Turtle
- [turtle/footprints2](https://openhome.cc/eGossip/OpenSCAD/lib2x-footprints2.html)
- [turtle/footprints3](https://openhome.cc/eGossip/OpenSCAD/lib2x-footprints3.html)
- [turtle/lsystem2](https://openhome.cc/eGossip/OpenSCAD/lib2x-lsystem2.html)
- [turtle/lsystem3](https://openhome.cc/eGossip/OpenSCAD/lib2x-lsystem3.html)
- [turtle/t2d](https://openhome.cc/eGossip/OpenSCAD/lib2x-t2d.html)
- [turtle/t3d](https://openhome.cc/eGossip/OpenSCAD/lib2x-t3d.html)
- [turtle/turtle2d](https://openhome.cc/eGossip/OpenSCAD/lib2x-turtle2d.html)
- [turtle/turtle3d](https://openhome.cc/eGossip/OpenSCAD/lib2x-turtle3d.html)

### Voxel
- [voxel/vx_ascii](https://openhome.cc/eGossip/OpenSCAD/lib2x-vx_ascii.html)
- [voxel/vx_bezier](https://openhome.cc/eGossip/OpenSCAD/lib2x-vx_bezier.html)
- [voxel/vx_contour](https://openhome.cc/eGossip/OpenSCAD/lib2x-vx_contour.html)
- [voxel/vx_circle](https://openhome.cc/eGossip/OpenSCAD/lib2x-vx_circle.html)
- [voxel/vx_curve](https://openhome.cc/eGossip/OpenSCAD/lib2x-vx_curve.html)
- [voxel/vx_cylinder](https://openhome.cc/eGossip/OpenSCAD/lib2x-vx_cylinder.html)
- [voxel/vx_difference](https://openhome.cc/eGossip/OpenSCAD/lib2x-vx_difference.html)
- [voxel/vx_from](https://openhome.cc/eGossip/OpenSCAD/lib2x-vx_from.html)
- [voxel/vx_gray](https://openhome.cc/eGossip/OpenSCAD/lib2x-vx_gray.html)
- [voxel/vx_intersection](https://openhome.cc/eGossip/OpenSCAD/lib2x-vx_intersection.html)
- [voxel/vx_line](https://openhome.cc/eGossip/OpenSCAD/lib2x-vx_line.html)
- [voxel/vx_polygon](https://openhome.cc/eGossip/OpenSCAD/lib2x-vx_polygon.html)
- [voxel/vx_polyline](https://openhome.cc/eGossip/OpenSCAD/lib2x-vx_polyline.html)
- [voxel/vx_sphere](https://openhome.cc/eGossip/OpenSCAD/lib2x-vx_sphere.html)
- [voxel/vx_union](https://openhome.cc/eGossip/OpenSCAD/lib2x-vx_union.html)

### Part
- [part/connector_peg](https://openhome.cc/eGossip/OpenSCAD/lib2x-connector_peg.html)
- [part/cone](https://openhome.cc/eGossip/OpenSCAD/lib2x-cone.html)
- [part/joint_T](https://openhome.cc/eGossip/OpenSCAD/lib2x-joint_T.html)

### Surface
- [surface/sf_bend](https://openhome.cc/eGossip/OpenSCAD/lib2x-sf_bend.html)
- [surface/sf_ring](https://openhome.cc/eGossip/OpenSCAD/lib2x-sf_ring.html)
- [surface/sf_solidify](https://openhome.cc/eGossip/OpenSCAD/lib2x-sf_solidify.html)
- [surface/sf_sphere](https://openhome.cc/eGossip/OpenSCAD/lib2x-sf_sphere.html)
- [surface/sf_square](https://openhome.cc/eGossip/OpenSCAD/lib2x-sf_square.html)
- [surface/sf_torus](https://openhome.cc/eGossip/OpenSCAD/lib2x-sf_torus.html

### Noise
- [noise/nz_cell](https://openhome.cc/eGossip/OpenSCAD/lib2x-nz_cell.html)
- [noise/nz_perlin1](https://openhome.cc/eGossip/OpenSCAD/lib2x-nz_perlin1.html)
- [noise/nz_perlin1s](https://openhome.cc/eGossip/OpenSCAD/lib2x-nz_perlin1s.html)
- [noise/nz_perlin2](https://openhome.cc/eGossip/OpenSCAD/lib2x-nz_perlin2.html)
- [noise/nz_perlin2s](https://openhome.cc/eGossip/OpenSCAD/lib2x-nz_perlin2s.html)
- [noise/nz_perlin3](https://openhome.cc/eGossip/OpenSCAD/lib2x-nz_perlin3.html)
- [noise/nz_perlin3s](https://openhome.cc/eGossip/OpenSCAD/lib2x-nz_perlin3s.html)
- [noise/nz_worley2](https://openhome.cc/eGossip/OpenSCAD/lib2x-nz_worley2.html)
- [noise/nz_worley2s](https://openhome.cc/eGossip/OpenSCAD/lib2x-nz_worley2s.html)
- [noise/nz_worley3](https://openhome.cc/eGossip/OpenSCAD/lib2x-nz_worley3.html)
- [noise/nz_worley3s](https://openhome.cc/eGossip/OpenSCAD/lib2x-nz_worley3s.html)

### Voronoi

- [voronoi/vrn2_cells_from](https://openhome.cc/eGossip/OpenSCAD/lib2x-vrn2_cells_from.html)
- [voronoi/vrn2_cells_space](https://openhome.cc/eGossip/OpenSCAD/lib2x-vrn2_cells_space.html)
- [voronoi/vrn2_from](https://openhome.cc/eGossip/OpenSCAD/lib2x-vrn2_from.html)
- [voronoi/vrn2_space](https://openhome.cc/eGossip/OpenSCAD/lib2x-vrn2_space.html)
- [voronoi/vrn3_from](https://openhome.cc/eGossip/OpenSCAD/lib2x-vrn3_from.html)
- [voronoi/vrn3_space](https://openhome.cc/eGossip/OpenSCAD/lib2x-vrn3_space.html)

### Maze

- [maze/mz_square_cells](https://openhome.cc/eGossip/OpenSCAD/lib2x-mz_square_cells.html)
- [maze/mz_square_get](https://openhome.cc/eGossip/OpenSCAD/lib2x-mz_square_get.html)
- [maze/mz_square_walls](https://openhome.cc/eGossip/OpenSCAD/lib2x-mz_square_walls.html)
- [maze/mz_hex_walls](https://openhome.cc/eGossip/OpenSCAD/lib2x-mz_hex_walls.html)
- [maze/mz_square_initialize](https://openhome.cc/eGossip/OpenSCAD/lib2x-mz_square_initialize.html)
- [maze/mz_hamiltonian](https://openhome.cc/eGossip/OpenSCAD/lib2x-mz_hamiltonian.html)