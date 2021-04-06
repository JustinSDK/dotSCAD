# dotSCAD 3.0

> **Reduce the burden of mathematics/algorithm when playing OpenSCAD.**

![dotSCAD](featured_img/RandomCityTaiwan.JPG)

[![license/LGPL](LICENSE.svg)](https://github.com/JustinSDK/lib-openscad/blob/master/LICENSE)

## Introduction

**This version Breaks Backward Compatibility and requires OpenSCAD 2021.01 or later!! Please see [Release Notes](RELEASE.md). You can still download v2.5 or older versions from [Releases](https://github.com/JustinSDK/dotSCAD/tags).**

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
- [`arc(radius, angle, width = 1, width_mode = "LINE_CROSS")`](https://openhome.cc/eGossip/OpenSCAD/lib3x-arc.html)
- [`hexagons(radius, spacing, levels)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-hexagons.html)
- [`hull_polyline2d(points, width = 1)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-hull_polyline2d.html)
- [`line2d(p1, p2, width = 1, p1Style = "CAP_SQUARE", p2Style =  "CAP_SQUARE")`](https://openhome.cc/eGossip/OpenSCAD/lib3x-line2d.html)
- [`multi_line_text(lines, line_spacing = 15, size = 10, font = "Arial", ...)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-multi_line_text.html)
- [`pie(radius, angle)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-pie.html)
- [`polyline2d(points, width = 1, startingStyle = "CAP_SQUARE", endingStyle = "CAP_SQUARE", ...)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-polyline2d.html)
- [`polygon_hull(points)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-polygon_hull.html)
- [`rounded_square(size, corner_r, center = false)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-rounded_square.html)

### 3D Module
- [`crystal_ball(radius, theta = 360, phi = 180, thickness = undef)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-crystal_ball.html)
- [`function_grapher(points, thickness = 1, style = "FACES")`](https://openhome.cc/eGossip/OpenSCAD/lib3x-function_grapher.html)
- [`hull_polyline3d(points, diameter = 1)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-hull_polyline3d.html)
- [`line3d(p1, p2, diameter = 1, p1Style = "CAP_CIRCLE", p2Style = "CAP_CIRCLE")`](https://openhome.cc/eGossip/OpenSCAD/lib3x-line3d.html)
- [`loft(sections, slices = 1)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-loft.html)
- [`polyhedron_hull(points)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-polyhedron_hull.html)
- [`polyline3d(points, diameter, startingStyle = "CAP_CIRCLE", endingStyle = "CAP_CIRCLE")`](https://openhome.cc/eGossip/OpenSCAD/lib3x-polyline3d.html)
- [`rounded_cube(size, corner_r, center = false)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-rounded_cube.html)
- [`rounded_cylinder(radius, h, round_r, convexity = 2, center = false)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-rounded_cylinder.html)
- [`starburst(r1, r2, n, height)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-starburst.html)
- [`sweep(sections, triangles = "SOLID")`](https://openhome.cc/eGossip/OpenSCAD/lib3x-sweep.html)

### Transformation
- [`along_with(points, angles, twist = 0, scale = 1.0, method = "AXIS_ANGLE")`](https://openhome.cc/eGossip/OpenSCAD/lib3x-along_with.html)
- [`bend(size, angle, frags = 24)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-bend.html)
- [`hollow_out(shell_thickness)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-hollow_out.html)
- [`shear(sx = [0, 0], sy = [0, 0], sz = [0, 0])`](https://openhome.cc/eGossip/OpenSCAD/lib3x-shear.html)

### 2D Function
- [`bijection_offset(pts, d, epsilon = 0.0001)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-bijection_offset.html)
- [`contours(points, threshold)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-contours.html)
- [`in_shape(shapt_pts, pt, include_edge = false, epsilon = 0.0001)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-in_shape.html)	
- [`trim_shape(shape_pts, from, to, epsilon = 0.0001)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-trim_shape.html)

### 2D/3D Function
- [`angle_between(vt1, vt2)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-angle_between.html)
- [`bezier_surface(t_step, ctrl_pts)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-bezier_surface.html)	
- [`bezier_smooth(path_pts, round_d, t_step = 0.1, closed = false, angle_threshold = 0)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-bezier_smooth.html)	
- [`cross_sections(shape_pts, path_pts, angles, twist = 0, scale = 1.0)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-cross_sections.html)
- [`in_polyline(line_pts, pt, epsilon = 0.0001)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-in_polyline.html)
- [`lines_intersection(line1, line2, ext = false, epsilon = 0.0001)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-lines_intersection.html)
- [`paths2sections(paths)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-paths2sections.html)
- [`path_scaling_sections(shape_pts, edge_path)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-path_scaling_sections.html)
- [`midpt_smooth(points, n, closed = false)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-midpt_smooth.html)

### Path
- [`arc_path(radius, angle)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-arc_path.html)
- [`archimedean_spiral(arm_distance, init_angle, point_distance, num_of_points, rt_dir = "CT_CLK")`](https://openhome.cc/eGossip/OpenSCAD/lib3x-archimedean_spiral.html)
- [`bauer_spiral(n, radius = 1, rt_dir = "CT_CLK")`](https://openhome.cc/eGossip/OpenSCAD/lib3x-bauer_spiral.html)
- [`bezier_curve(t_step, points)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-bezier_curve.html)
- [`bspline_curve(t_step, degree, points, knots, weights)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-bspline_curve.html)
- [`curve(t_step, points, tightness = 0)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-curve.html)
- [`fibonacci_lattice(n, radius = 1, dir = "CT_CLK")`](https://openhome.cc/eGossip/OpenSCAD/lib3x-fibonacci_lattice.html)
- [`golden_spiral(from, to, point_distance, rt_dir = "CT_CLK")`](https://openhome.cc/eGossip/OpenSCAD/lib3x-golden_spiral.html)
- [`helix(radius, levels, level_dist, vt_dir = "SPI_DOWN", rt_dir = "CT_CLK")`](https://openhome.cc/eGossip/OpenSCAD/lib3x-helix.html)
- [`sphere_spiral(radius, za_step, z_circles = 1, begin_angle = 0, end_angle = 0, ...)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-sphere_spiral.html)
- [`torus_knot(p, q, phi_step)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-torus_knot.html)

### Extrusion
- [`bend_extrude(size, thickness, angle, frags = 24)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-bend_extrude.html)	
- [`box_extrude(height, shell_thickness, bottom_thickness, offset_mode = "delta", chamfer = false, ...)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-box_extrude.html)
- [`ellipse_extrude(semi_minor_axis, height, center = false, convexity = 10, twist = 0, slices = 20)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-ellipse_extrude.html)
- [`rounded_extrude(size, round_r, angle = 90, twist = 0, convexity = 10)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-rounded_extrude.html)
- [`stereographic_extrude(shadow_side_leng)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-stereographic_extrude.html)

### 2D Shape
- [`shape_arc(radius, angle, width, width_mode = "LINE_CROSS")`](https://openhome.cc/eGossip/OpenSCAD/lib3x-shape_arc.html)
- [`shape_circle(radius, n)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-shape_circle.html)
- [`shape_cyclicpolygon(sides, circle_r, corner_r)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-shape_cyclicpolygon.html)
- [`shape_ellipse(axes)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-shape_ellipse.html)
- [`shape_liquid_splitting(radius, centre_dist, tangent_angle = 30, t_step = 0.1)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-shape_liquid_splitting.html)
- [`shape_path_extend(stroke_pts, path_pts, scale = 1.0, closed = false)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-shape_path_extend.html)
- [`shape_pentagram(r)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-shape_pentagram.html)
- [`shape_pie(radius, angle)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-shape_pie.html)	
- [`shape_square(size, corner_r = 0)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-shape_square.html)
- [`shape_starburst(r1, r2, n)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-shape_starburst.html)
- [`shape_superformula(phi_step, m1, m2, n1, n2 = 1, n3 = 1, a = 1, b = 1)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-shape_superformula.html)
- [`shape_taiwan(h, distance = 0)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-shape_taiwan.html)
- [`shape_trapezium(length, h, corner_r = 0)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-shape_trapezium.html)

### 2D Shape Extrusion
- [`archimedean_spiral_extrude(shape_pts, arm_distance, init_angle, point_distance, num_of_points, ...)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-archimedean_spiral_extrude.html)
- [`golden_spiral_extrude(shape_pts, from, to, point_distance, ...)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-golden_spiral_extrude.html)
- [`helix_extrude(shape_pts, radius, levels, level_dist, ...)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-helix_extrude.html)
- [`path_extrude(shape_pts, path_pts, ...)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-path_extrude.html)
- [`ring_extrude(shape_pts, radius, angle = 360, ...)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-ring_extrude.html)
- [`sphere_spiral_extrude(shape_pts, radius, za_step, ...)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-sphere_spiral_extrude.html)

### Util
- list
	- [`util/bsearch(sorted, target)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-bsearch.html)
	- [`util/has(lt, elem, sorted = false)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-has.html)
	- [`util/find_index(lt, test)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-find_index.html)
	- [`util/dedup(lt, ...)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-dedup.html)	
	- [`util/flat(lt, depth = 1)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-flat.html)
	- [`util/reverse(lt)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-reverse.html)
	- [`util/slice(lt, begin, end)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-slice.html)
	- [`util/sort(lt, by = "idx", idx = 0)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-sort.html)
	- [`util/sum(lt)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-sum.html)
	- [`util/swap(lt, i, j)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-swap.html)
	- [`util/zip(lts, combine)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-zip.html)
	- [`util/every(lt, test)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-every.html)
	- [`util/some(lt, test)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-some.html)
- random
	- [`util/choose(choices, seed)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-choose.html)
	- [`util/rand(min_value = 0, max_value = 1, seed_value = undef)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-rand.html)
	- [`util/shuffle(lt, seed = undef)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-shuffle.html)
- string
	- [`util/parse_number(t)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-parse_number.html)
	- [`util/split_str(t, delimiter)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-split_str.html)
	- [`util/sub_str(t, begin, end)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-sub_str.html)
- math
	- [`util/degrees(radians)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-degrees.html)
	- [`util/radians(degrees)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-radians.html)
	- [`util/polar_coordinate(point)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-polar_coordinate.html)
	- [`util/spherical_coordinate(point)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-spherical_coordinate.html)
	- [`util/lerp(v1, v2, amt)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-lerp.html)
	- [`util/fibseq(from, to)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-fibseq.html)	
- set
    - [`util/set/hashset(lt, ...)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-hashset.html)
	- [`util/set/hashset_add(set, elem, ...)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-hashset_add.html)
	- [`util/set/hashset_has(set, elem, ...)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-hashset_has.html)
	- [`util/set/hashset_del(set, elem, ...)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-hashset_del.html)
	- [`util/set/hashset_len(set)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-hashset_len.html)
	- [`util/set/hashset_elems(set)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-hashset_elems.html)
- map
    - [`util/map/hashmap(kv_lt, ...)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-hashmap.html)
	- [`util/map/hashmap_put(map, key, value, ...)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-hashmap_put.html)
	- [`util/map/hashmap_get(map, key, ...)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-hashmap_get.html)
	- [`util/map/hashmap_del(map, key, ...)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-hashmap_del.html)
	- [`util/map/hashmap_len(map)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-hashmap_len.html)
	- [`util/map/hashmap_keys(map)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-hashmap_keys.html)
	- [`util/map/hashmap_values(map)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-hashmap_values.html)
	- [`util/map/hashmap_entries(map)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-hashmap_entries.html)

### Matrix
- [`matrix/m_determinant(m)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-m_determinant.html)
- [`matrix/m_mirror(v)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-m_mirror.html)
- [`matrix/m_rotation(a, v)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-m_rotation.html)
- [`matrix/m_scaling(s)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-m_scaling.html)
- [`matrix/m_shearing(sx = [0, 0], sy = [0, 0], sz = [0, 0])`](https://openhome.cc/eGossip/OpenSCAD/lib3x-m_shearing.html)
- [`matrix/m_translation(v)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-m_translation.html)

### Point Transformation
- [`ptf/ptf_bend(size, point, radius, angle)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-ptf_bend.html)
- [`ptf/ptf_circle(size, point)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-ptf_circle.html)
- [`ptf/ptf_ring(size, point, radius, angle = 360, twist = 0)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-ptf_ring.html)
- [`ptf/ptf_rotate(point, a, v)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-ptf_rotate.html)
- [`ptf/ptf_sphere(size, point, radius, angle = [180, 360])`](https://openhome.cc/eGossip/OpenSCAD/lib3x-ptf_sphere.html)
- [`ptf/ptf_torus(size, point, radius, angle = [360, 360], twist = 0)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-ptf_torus.html)
- [`ptf/ptf_x_twist(size, point, angle)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-ptf_x_twist.html)
- [`ptf/ptf_y_twist(size, point, angle)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-ptf_y_twist.html)

----

### Turtle
- [`turtle/footprints2(cmds, start = [0, 0])`](https://openhome.cc/eGossip/OpenSCAD/lib3x-footprints2.html)
- [`turtle/footprints3(cmds, start = [0, 0, 0])`](https://openhome.cc/eGossip/OpenSCAD/lib3x-footprints3.html)
- [`turtle/lsystem2(axiom, rules, n, angle, leng = 1, heading = 0, ...)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-lsystem2.html)
- [`turtle/lsystem3(axiom, rules, n, angle, leng = 1, heading = 0, ...)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-lsystem3.html)
- [`turtle/t2d(t, cmd, point, angle, leng)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-t2d.html)
- [`turtle/t3d(t, cmd, point, unit_vectors, leng, angle)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-t3d.html)

### Voxel
- [`voxel/vx_ascii(char, center = false, invert = false)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-vx_ascii.html)
- [`voxel/vx_bezier(p1, p2, p3, p4)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-vx_bezier.html)
- [`voxel/vx_circle(radius, filled = false)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-vx_circle.html)
- [`voxel/vx_contour(points, sorted = false)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-vx_contour.html)
- [`voxel/vx_curve(points, tightness = 0)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-vx_curve.html)
- [`voxel/vx_cylinder(r, h, filled = false, thickness = 1)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-vx_cylinder.html)
- [`voxel/vx_difference(points1, points2)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-vx_difference.html)
- [`voxel/vx_from(binaries, center = false, invert = false)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-vx_from.html)
- [`voxel/vx_gray(levels, center = false, invert = false, normalize = false)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-vx_gray.html)
- [`voxel/vx_intersection(points1, points2)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-vx_intersection.html)
- [`voxel/vx_line(p1, p2)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-vx_line.html)
- [`voxel/vx_polygon(points, filled = false)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-vx_polygon.html)
- [`voxel/vx_polyline(points)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-vx_polyline.html)
- [`voxel/vx_sphere(radius, filled = false, thickness = 1)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-vx_sphere.html)
- [`voxel/vx_union(points1, points2)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-vx_union.html)

### Part
- [`part/cone(radius, length = 0, spacing = 0.5, angle = 50, void = false, ends = false)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-cone.html)
- [`part/connector_peg(radius, height, spacing = 0.5, void = false, ends = false)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-connector_peg.html)
- [`part/joint_T(shaft_r, shaft_h, t_leng, thickness, spacing = 0.5, center = false)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-joint_T.html)

### Surface
- [`surface/sf_bend(levels, radius, thickness, depth, angle = 180, invert = false)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-sf_bend.html)
- [`surface/sf_ring(levels, radius, thickness, depth, angle = 360, twist = 0, invert = false)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-sf_ring.html)
- [`surface/sf_solidify(surface1, surface2, slicing = "SLASH")`](https://openhome.cc/eGossip/OpenSCAD/lib3x-sf_solidify.html)
- [`surface/sf_sphere(levels, radius, thickness, depth, angle = [180, 360], invert = false)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-sf_sphere.html)
- [`surface/sf_square(levels, thickness, depth, x_twist = 0, y_twist = 0, invert = false)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-sf_square.html)
- [`surface/sf_torus(levels, radius, thickness, depth, angle = [360, 360], twist = 0, invert = false)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-sf_torus.html)

### Noise
- [`noise/nz_cell(points, p, dist = "euclidean")`](https://openhome.cc/eGossip/OpenSCAD/lib3x-nz_cell.html)
- [`noise/nz_perlin1(x, seed = undef)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-nz_perlin1.html)
- [`noise/nz_perlin1s(xs, seed = undef)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-nz_perlin1s.html)
- [`noise/nz_perlin2(x, y, seed = undef)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-nz_perlin2.html)
- [`noise/nz_perlin2s(points, seed = undef)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-nz_perlin2s.html)
- [`noise/nz_perlin3(x, y, z, seed = undef)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-nz_perlin3.html)
- [`noise/nz_perlin3s(points, seed = undef)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-nz_perlin3s.html)
- [`noise/nz_worley2(x, y, seed = undef, grid_w = 10, dist = "euclidean")`](https://openhome.cc/eGossip/OpenSCAD/lib3x-nz_worley2.html)
- [`noise/nz_worley2s(points, seed = undef, grid_w = 10, dist = "euclidean")`](https://openhome.cc/eGossip/OpenSCAD/lib3x-nz_worley2s.html)
- [`noise/nz_worley3(x, y, z, seed = undef, tile_w = 10, dist = "euclidean")`](https://openhome.cc/eGossip/OpenSCAD/lib3x-nz_worley3.html)
- [`noise/nz_worley3s(points, seed = undef, tile_w = 10, dist = "euclidean")`](https://openhome.cc/eGossip/OpenSCAD/lib3x-nz_worley3s.html)

### Voronoi

- [`voronoi/vrn2_cells_from(points)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-vrn2_cells_from.html)
- [`voronoi/vrn2_cells_space(size, grid_w, seed = undef)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-vrn2_cells_space.html)
- [`voronoi/vrn2_from(points, spacing = 1, r = 0, delta = 0, chamfer = false, region_type = "square")`](https://openhome.cc/eGossip/OpenSCAD/lib3x-vrn2_from.html)
- [`voronoi/vrn2_space(size, grid_w, seed = undef, spacing = 1, r = 0, delta = 0, chamfer = false, region_type = "square")`](https://openhome.cc/eGossip/OpenSCAD/lib3x-vrn2_space.html)
- [`voronoi/vrn3_from(points, spacing = 1)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-vrn3_from.html)
- [`voronoi/vrn3_space(size, grid_w, seed = undef, spacing = 1)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-vrn3_space.html)

### Maze

- [`maze/mz_square_cells(rows, columns, start = [0, 0], ...)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-mz_square_cells.html)
- [`maze/mz_square_get(cell, query)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-mz_square_get.html)
- [`maze/mz_square_walls(cells, rows, columns, cell_width, left_border = true, bottom_border = true)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-mz_square_walls.html)
- [`maze/mz_hex_walls(cells, rows, columns, cell_radius, left_border = true, bottom_border = true)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-mz_hex_walls.html)
- [`maze/mz_square_initialize(rows, columns, mask)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-mz_square_initialize.html)
- [`maze/mz_hamiltonian(rows, columns, start = [0, 0], seed = undef)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-mz_hamiltonian.html)
- [`maze/mz_theta_cells(rows, beginning_number, start = [0, 0], seed = undef)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-mz_theta_cells.html)
- [`maze/mz_theta_get(cell, query)`](https://openhome.cc/eGossip/OpenSCAD/lib3x-mz_theta_get.html)