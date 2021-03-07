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
- [arc](https://openhome.cc/eGossip/OpenSCAD/lib3x-arc.html)
- [hexagons](https://openhome.cc/eGossip/OpenSCAD/lib3x-hexagons.html)
- [hull_polyline2d](https://openhome.cc/eGossip/OpenSCAD/lib3x-hull_polyline2d.html)
- [line2d](https://openhome.cc/eGossip/OpenSCAD/lib3x-line2d.html)
- [multi_line_text](https://openhome.cc/eGossip/OpenSCAD/lib3x-multi_line_text.html)
- [pie](https://openhome.cc/eGossip/OpenSCAD/lib3x-pie.html)
- [polyline2d](https://openhome.cc/eGossip/OpenSCAD/lib3x-polyline2d.html)
- [polygon_hull](https://openhome.cc/eGossip/OpenSCAD/lib3x-polygon_hull.html)
- [rounded_square](https://openhome.cc/eGossip/OpenSCAD/lib3x-rounded_square.html)

### 3D Module
- [crystal_ball](https://openhome.cc/eGossip/OpenSCAD/lib3x-crystal_ball.html)
- [function_grapher](https://openhome.cc/eGossip/OpenSCAD/lib3x-function_grapher.html)
- [hull_polyline3d](https://openhome.cc/eGossip/OpenSCAD/lib3x-hull_polyline3d.html)
- [line3d](https://openhome.cc/eGossip/OpenSCAD/lib3x-line3d.html)
- [loft](https://openhome.cc/eGossip/OpenSCAD/lib3x-loft.html)
- [polyhedron_hull](https://openhome.cc/eGossip/OpenSCAD/lib3x-polyhedron_hull.html)
- [polyline3d](https://openhome.cc/eGossip/OpenSCAD/lib3x-polyline3d.html)
- [rounded_cube](https://openhome.cc/eGossip/OpenSCAD/lib3x-rounded_cube.html)
- [rounded_cylinder](https://openhome.cc/eGossip/OpenSCAD/lib3x-rounded_cylinder.html)
- [starburst](https://openhome.cc/eGossip/OpenSCAD/lib3x-starburst.html)
- [sweep](https://openhome.cc/eGossip/OpenSCAD/lib3x-sweep.html)

### Transformation
- [along_with](https://openhome.cc/eGossip/OpenSCAD/lib3x-along_with.html)
- [bend](https://openhome.cc/eGossip/OpenSCAD/lib3x-bend.html)
- [hollow_out](https://openhome.cc/eGossip/OpenSCAD/lib3x-hollow_out.html)
- [shear](https://openhome.cc/eGossip/OpenSCAD/lib3x-shear.html)

### 2D Function
- [bijection_offset](https://openhome.cc/eGossip/OpenSCAD/lib3x-bijection_offset.html)
- [contours](https://openhome.cc/eGossip/OpenSCAD/lib3x-contours.html)
- [in_shape](https://openhome.cc/eGossip/OpenSCAD/lib3x-in_shape.html)	
- [trim_shape](https://openhome.cc/eGossip/OpenSCAD/lib3x-trim_shape.html)

### 2D/3D Function
- [angle_between](https://openhome.cc/eGossip/OpenSCAD/lib3x-angle_between.html)
- [bezier_surface](https://openhome.cc/eGossip/OpenSCAD/lib3x-bezier_surface.html)	
- [bezier_smooth](https://openhome.cc/eGossip/OpenSCAD/lib3x-bezier_smooth.html)	
- [cross_sections](https://openhome.cc/eGossip/OpenSCAD/lib3x-cross_sections.html)
- [in_polyline](https://openhome.cc/eGossip/OpenSCAD/lib3x-in_polyline.html)
- [lines_intersection](https://openhome.cc/eGossip/OpenSCAD/lib3x-lines_intersection.html)
- [paths2sections](https://openhome.cc/eGossip/OpenSCAD/lib3x-paths2sections.html)
- [path_scaling_sections](https://openhome.cc/eGossip/OpenSCAD/lib3x-path_scaling_sections.html)
- [midpt_smooth](https://openhome.cc/eGossip/OpenSCAD/lib3x-midpt_smooth.html)

### Path
- [arc_path](https://openhome.cc/eGossip/OpenSCAD/lib3x-arc_path.html)
- [archimedean_spiral](https://openhome.cc/eGossip/OpenSCAD/lib3x-archimedean_spiral.html)
- [bauer_spiral](https://openhome.cc/eGossip/OpenSCAD/lib3x-bauer_spiral.html)
- [bezier_curve](https://openhome.cc/eGossip/OpenSCAD/lib3x-bezier_curve.html)
- [bspline_curve](https://openhome.cc/eGossip/OpenSCAD/lib3x-bspline_curve.html)
- [curve](https://openhome.cc/eGossip/OpenSCAD/lib3x-curve.html)
- [fibonacci_lattice](https://openhome.cc/eGossip/OpenSCAD/lib3x-fibonacci_lattice.html)
- [golden_spiral](https://openhome.cc/eGossip/OpenSCAD/lib3x-golden_spiral.html)
- [helix](https://openhome.cc/eGossip/OpenSCAD/lib3x-helix.html)
- [sphere_spiral](https://openhome.cc/eGossip/OpenSCAD/lib3x-sphere_spiral.html)
- [torus_knot](https://openhome.cc/eGossip/OpenSCAD/lib3x-torus_knot.html)

### Extrusion
- [bend_extrude](https://openhome.cc/eGossip/OpenSCAD/lib3x-bend_extrude.html)	
- [box_extrude](https://openhome.cc/eGossip/OpenSCAD/lib3x-box_extrude.html)
- [ellipse_extrude](https://openhome.cc/eGossip/OpenSCAD/lib3x-ellipse_extrude.html)
- [rounded_extrude](https://openhome.cc/eGossip/OpenSCAD/lib3x-rounded_extrude.html)
- [stereographic_extrude](https://openhome.cc/eGossip/OpenSCAD/lib3x-stereographic_extrude.html)

### 2D Shape
- [shape_arc](https://openhome.cc/eGossip/OpenSCAD/lib3x-shape_arc.html)
- [shape_circle](https://openhome.cc/eGossip/OpenSCAD/lib3x-shape_circle.html)
- [shape_cyclicpolygon](https://openhome.cc/eGossip/OpenSCAD/lib3x-shape_cyclicpolygon.html)
- [shape_ellipse](https://openhome.cc/eGossip/OpenSCAD/lib3x-shape_ellipse.html)
- [shape_liquid_splitting](https://openhome.cc/eGossip/OpenSCAD/lib3x-shape_liquid_splitting.html)
- [shape_path_extend](https://openhome.cc/eGossip/OpenSCAD/lib3x-shape_path_extend.html)
- [shape_pentagram](https://openhome.cc/eGossip/OpenSCAD/lib3x-shape_pentagram.html)
- [shape_pie](https://openhome.cc/eGossip/OpenSCAD/lib3x-shape_pie.html)	
- [shape_square](https://openhome.cc/eGossip/OpenSCAD/lib3x-shape_square.html)
- [shape_starburst](https://openhome.cc/eGossip/OpenSCAD/lib3x-shape_starburst.html)
- [shape_superformula](https://openhome.cc/eGossip/OpenSCAD/lib3x-shape_superformula.html)
- [shape_taiwan](https://openhome.cc/eGossip/OpenSCAD/lib3x-shape_taiwan.html)
- [shape_trapezium](https://openhome.cc/eGossip/OpenSCAD/lib3x-shape_trapezium.html)

### 2D Shape Extrusion
- [archimedean_spiral_extrude](https://openhome.cc/eGossip/OpenSCAD/lib3x-archimedean_spiral_extrude.html)
- [golden_spiral_extrude](https://openhome.cc/eGossip/OpenSCAD/lib3x-golden_spiral_extrude.html)
- [helix_extrude](https://openhome.cc/eGossip/OpenSCAD/lib3x-helix_extrude.html)
- [path_extrude](https://openhome.cc/eGossip/OpenSCAD/lib3x-path_extrude.html)
- [ring_extrude](https://openhome.cc/eGossip/OpenSCAD/lib3x-ring_extrude.html)
- [sphere_spiral_extrude](https://openhome.cc/eGossip/OpenSCAD/lib3x-sphere_spiral_extrude.html)

### Util
- list
	- [util/bsearch](https://openhome.cc/eGossip/OpenSCAD/lib3x-bsearch.html)
	- [util/has](https://openhome.cc/eGossip/OpenSCAD/lib3x-has.html)
	- [util/find_index](https://openhome.cc/eGossip/OpenSCAD/lib3x-find_index.html)
	- [util/dedup](https://openhome.cc/eGossip/OpenSCAD/lib3x-dedup.html)	
	- [util/flat](https://openhome.cc/eGossip/OpenSCAD/lib3x-flat.html)
	- [util/reverse](https://openhome.cc/eGossip/OpenSCAD/lib3x-reverse.html)
	- [util/slice](https://openhome.cc/eGossip/OpenSCAD/lib3x-slice.html)
	- [util/sort](https://openhome.cc/eGossip/OpenSCAD/lib3x-sort.html)
	- [util/sum](https://openhome.cc/eGossip/OpenSCAD/lib3x-sum.html)
	- [util/swap](https://openhome.cc/eGossip/OpenSCAD/lib3x-swap.html)
	- [util/zip](https://openhome.cc/eGossip/OpenSCAD/lib3x-zip.html)
	- [util/every](https://openhome.cc/eGossip/OpenSCAD/lib3x-every.html)
	- [util/some](https://openhome.cc/eGossip/OpenSCAD/lib3x-some.html)
- random
	- [util/choose](https://openhome.cc/eGossip/OpenSCAD/lib3x-choose.html)
	- [util/rand](https://openhome.cc/eGossip/OpenSCAD/lib3x-rand.html)
	- [util/shuffle](https://openhome.cc/eGossip/OpenSCAD/lib3x-shuffle.html)
- string
	- [util/parse_number](https://openhome.cc/eGossip/OpenSCAD/lib3x-parse_number.html)
	- [util/split_str](https://openhome.cc/eGossip/OpenSCAD/lib3x-split_str.html)
	- [util/sub_str](https://openhome.cc/eGossip/OpenSCAD/lib3x-sub_str.html)
- math
	- [util/degrees](https://openhome.cc/eGossip/OpenSCAD/lib3x-degrees.html)
	- [util/radians](https://openhome.cc/eGossip/OpenSCAD/lib3x-radians.html)
	- [util/polar_coordinate](https://openhome.cc/eGossip/OpenSCAD/lib3x-polar_coordinate.html)
	- [util/spherical_coordinate](https://openhome.cc/eGossip/OpenSCAD/lib3x-spherical_coordinate.html)
	- [util/lerp](https://openhome.cc/eGossip/OpenSCAD/lib3x-lerp.html)
	- [util/fibseq](https://openhome.cc/eGossip/OpenSCAD/lib3x-fibseq.html)	
- set
    - `util/set/hashset`
	- `util/set/hashset_add`
	- `util/set/hashset_has`
	- `util/set/hashset_del`
	- `util/set/hashset_len`
	- `util/set/hashset_elems`
- map
    - `util/map/hashmap`
	- `util/map/hashmap_put`
	- `util/map/hashmap_get`
	- `util/map/hashmap_del`
	- `util/map/hashmap_len`
	- `util/map/hashmap_keys`
	- `util/map/hashmap_values`
	- `util/map/hashmap_entries`

### Matrix
- [matrix/m_determinant](https://openhome.cc/eGossip/OpenSCAD/lib3x-m_determinant.html)
- [matrix/m_mirror](https://openhome.cc/eGossip/OpenSCAD/lib3x-m_mirror.html)
- [matrix/m_rotation](https://openhome.cc/eGossip/OpenSCAD/lib3x-m_rotation.html)
- [matrix/m_scaling](https://openhome.cc/eGossip/OpenSCAD/lib3x-m_scaling.html)
- [matrix/m_shearing](https://openhome.cc/eGossip/OpenSCAD/lib3x-m_shearing.html)
- [matrix/m_translation](https://openhome.cc/eGossip/OpenSCAD/lib3x-m_translation.html)

### Point Transformation
- [ptf/ptf_bend](https://openhome.cc/eGossip/OpenSCAD/lib3x-ptf_bend.html)
- [ptf/ptf_circle](https://openhome.cc/eGossip/OpenSCAD/lib3x-ptf_circle.html)
- [ptf/ptf_ring](https://openhome.cc/eGossip/OpenSCAD/lib3x-ptf_ring.html)
- [ptf/ptf_rotate](https://openhome.cc/eGossip/OpenSCAD/lib3x-ptf_rotate.html)
- [ptf/ptf_sphere](https://openhome.cc/eGossip/OpenSCAD/lib3x-ptf_sphere.html)
- [ptf/ptf_torus](https://openhome.cc/eGossip/OpenSCAD/lib3x-ptf_torus.html)
- [ptf/ptf_x_twist](https://openhome.cc/eGossip/OpenSCAD/lib3x-ptf_x_twist.html)
- [ptf/ptf_y_twist](https://openhome.cc/eGossip/OpenSCAD/lib3x-ptf_y_twist.html)

----

### Turtle
- [turtle/footprints2](https://openhome.cc/eGossip/OpenSCAD/lib3x-footprints2.html)
- [turtle/footprints3](https://openhome.cc/eGossip/OpenSCAD/lib3x-footprints3.html)
- [turtle/lsystem2](https://openhome.cc/eGossip/OpenSCAD/lib3x-lsystem2.html)
- [turtle/lsystem3](https://openhome.cc/eGossip/OpenSCAD/lib3x-lsystem3.html)
- [turtle/t2d](https://openhome.cc/eGossip/OpenSCAD/lib3x-t2d.html)
- [turtle/t3d](https://openhome.cc/eGossip/OpenSCAD/lib3x-t3d.html)

### Voxel
- [voxel/vx_ascii](https://openhome.cc/eGossip/OpenSCAD/lib3x-vx_ascii.html)
- [voxel/vx_bezier](https://openhome.cc/eGossip/OpenSCAD/lib3x-vx_bezier.html)
- [voxel/vx_contour](https://openhome.cc/eGossip/OpenSCAD/lib3x-vx_contour.html)
- [voxel/vx_circle](https://openhome.cc/eGossip/OpenSCAD/lib3x-vx_circle.html)
- [voxel/vx_curve](https://openhome.cc/eGossip/OpenSCAD/lib3x-vx_curve.html)
- [voxel/vx_cylinder](https://openhome.cc/eGossip/OpenSCAD/lib3x-vx_cylinder.html)
- [voxel/vx_difference](https://openhome.cc/eGossip/OpenSCAD/lib3x-vx_difference.html)
- [voxel/vx_from](https://openhome.cc/eGossip/OpenSCAD/lib3x-vx_from.html)
- [voxel/vx_gray](https://openhome.cc/eGossip/OpenSCAD/lib3x-vx_gray.html)
- [voxel/vx_intersection](https://openhome.cc/eGossip/OpenSCAD/lib3x-vx_intersection.html)
- [voxel/vx_line](https://openhome.cc/eGossip/OpenSCAD/lib3x-vx_line.html)
- [voxel/vx_polygon](https://openhome.cc/eGossip/OpenSCAD/lib3x-vx_polygon.html)
- [voxel/vx_polyline](https://openhome.cc/eGossip/OpenSCAD/lib3x-vx_polyline.html)
- [voxel/vx_sphere](https://openhome.cc/eGossip/OpenSCAD/lib3x-vx_sphere.html)
- [voxel/vx_union](https://openhome.cc/eGossip/OpenSCAD/lib3x-vx_union.html)

### Part
- [part/connector_peg](https://openhome.cc/eGossip/OpenSCAD/lib3x-connector_peg.html)
- [part/cone](https://openhome.cc/eGossip/OpenSCAD/lib3x-cone.html)
- [part/joint_T](https://openhome.cc/eGossip/OpenSCAD/lib3x-joint_T.html)

### Surface
- [surface/sf_bend](https://openhome.cc/eGossip/OpenSCAD/lib3x-sf_bend.html)
- [surface/sf_ring](https://openhome.cc/eGossip/OpenSCAD/lib3x-sf_ring.html)
- [surface/sf_solidify](https://openhome.cc/eGossip/OpenSCAD/lib3x-sf_solidify.html)
- [surface/sf_sphere](https://openhome.cc/eGossip/OpenSCAD/lib3x-sf_sphere.html)
- [surface/sf_square](https://openhome.cc/eGossip/OpenSCAD/lib3x-sf_square.html)
- [surface/sf_torus](https://openhome.cc/eGossip/OpenSCAD/lib3x-sf_torus.html)

### Noise
- [noise/nz_cell](https://openhome.cc/eGossip/OpenSCAD/lib3x-nz_cell.html)
- [noise/nz_perlin1](https://openhome.cc/eGossip/OpenSCAD/lib3x-nz_perlin1.html)
- [noise/nz_perlin1s](https://openhome.cc/eGossip/OpenSCAD/lib3x-nz_perlin1s.html)
- [noise/nz_perlin2](https://openhome.cc/eGossip/OpenSCAD/lib3x-nz_perlin2.html)
- [noise/nz_perlin2s](https://openhome.cc/eGossip/OpenSCAD/lib3x-nz_perlin2s.html)
- [noise/nz_perlin3](https://openhome.cc/eGossip/OpenSCAD/lib3x-nz_perlin3.html)
- [noise/nz_perlin3s](https://openhome.cc/eGossip/OpenSCAD/lib3x-nz_perlin3s.html)
- [noise/nz_worley2](https://openhome.cc/eGossip/OpenSCAD/lib3x-nz_worley2.html)
- [noise/nz_worley2s](https://openhome.cc/eGossip/OpenSCAD/lib3x-nz_worley2s.html)
- [noise/nz_worley3](https://openhome.cc/eGossip/OpenSCAD/lib3x-nz_worley3.html)
- [noise/nz_worley3s](https://openhome.cc/eGossip/OpenSCAD/lib3x-nz_worley3s.html)

### Voronoi

- [voronoi/vrn2_cells_from](https://openhome.cc/eGossip/OpenSCAD/lib3x-vrn2_cells_from.html)
- [voronoi/vrn2_cells_space](https://openhome.cc/eGossip/OpenSCAD/lib3x-vrn2_cells_space.html)
- [voronoi/vrn2_from](https://openhome.cc/eGossip/OpenSCAD/lib3x-vrn2_from.html)
- [voronoi/vrn2_space](https://openhome.cc/eGossip/OpenSCAD/lib3x-vrn2_space.html)
- [voronoi/vrn3_from](https://openhome.cc/eGossip/OpenSCAD/lib3x-vrn3_from.html)
- [voronoi/vrn3_space](https://openhome.cc/eGossip/OpenSCAD/lib3x-vrn3_space.html)

### Maze

- [maze/mz_square_cells](https://openhome.cc/eGossip/OpenSCAD/lib3x-mz_square_cells.html)
- [maze/mz_square_get](https://openhome.cc/eGossip/OpenSCAD/lib3x-mz_square_get.html)
- [maze/mz_square_walls](https://openhome.cc/eGossip/OpenSCAD/lib3x-mz_square_walls.html)
- [maze/mz_hex_walls](https://openhome.cc/eGossip/OpenSCAD/lib3x-mz_hex_walls.html)
- [maze/mz_square_initialize](https://openhome.cc/eGossip/OpenSCAD/lib3x-mz_square_initialize.html)
- [maze/mz_hamiltonian](https://openhome.cc/eGossip/OpenSCAD/lib3x-mz_hamiltonian.html)
- [maze/mz_theta_cells](https://openhome.cc/eGossip/OpenSCAD/lib3x-mz_theta_cells.html)
- [maze/mz_theta_get](https://openhome.cc/eGossip/OpenSCAD/lib3x-mz_theta_get.html)