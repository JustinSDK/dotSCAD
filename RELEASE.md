> Version numbers are based on [Semantic Versioning](https://semver.org/).

# v3.3

## Deprecated

 Signature | Description
--|--
**rails2sections** | use [`maxtrix/m_transpose`](https://openhome.cc/eGossip/OpenSCAD/lib3x-m_transpose.html) instead.
**util/sort** | use [`util/sorted`](https://openhome.cc/eGossip/OpenSCAD/lib3x-sorted.html) instead.
**util/has** | use [`util/contains`](https://openhome.cc/eGossip/OpenSCAD/lib3x-contains.html) instead.
**util/bsearch** | use [`util/binary_search`](https://openhome.cc/eGossip/OpenSCAD/lib3x-binary_search.html) instead.
**maze/mz_square_cells** | use [`maze/mz_square`](https://openhome.cc/eGossip/OpenSCAD/lib3x-mz_square.html).
**maze/mz_square_walls** | use [`maze/mz_squarewalls`](https://openhome.cc/eGossip/OpenSCAD/lib3x-mz_squarewalls.html) instead.
**maze/mz_hex_walls** | use [`maze/mz_hexwalls`](https://openhome.cc/eGossip/OpenSCAD/lib3x-mz_hexwalls.html) instead.
**maze/mz_theta_cells** | use [`maze/mz_theta`](https://openhome.cc/eGossip/OpenSCAD/lib3x-mz_theta.html) instead.


## Util

 Signature | Description
--|--
[**util/sorted**(lt[, cmp, key, reverse])](https://openhome.cc/eGossip/OpenSCAD/lib3x-sorted.html) | sort a list.
[**util/contains**(lt, elem)](https://openhome.cc/eGossip/OpenSCAD/lib3x-contains.html) | return `true` if `lt` contains `elem`.
[**util/binary_search**(sorted, target[, lo, hi])](https://openhome.cc/eGossip/OpenSCAD/lib3x-binary_search.html) | search a value in a sorted list.
[**util/count**(lt, test)](https://openhome.cc/eGossip/OpenSCAD/lib3x-count.html) | return the number of times `test` return `true` in the list.

## Matrix

 Signature | Description
--|--
[**matrix/m_replace**(m, i, j, value)](https://openhome.cc/eGossip/OpenSCAD/lib3x-m_replace.html) | replace the aᵢⱼ element of a matrix.

## Triangle

 Signature | Description
--|--
[**triangle/tri_subdivide**(shape_pts[, n])](https://openhome.cc/eGossip/OpenSCAD/lib3x-tri_subdivide.html) | subdivide a triangle `n` times.

## Point Picking

 Signature | Description
--|--
[**pp/pp_disk**(radius, value_count[, seed])](https://openhome.cc/eGossip/OpenSCAD/lib3x-pp_disk.html) | generate random points over a disk.
[**pp/pp_sphere**(radius, value_count[, seed])](https://openhome.cc/eGossip/OpenSCAD/lib3x-pp_sphere.html) | pick random points on the surface of a sphere.
[**pp/pp_poisson2**(size, r[, start, k, seed])](https://openhome.cc/eGossip/OpenSCAD/lib3x-pp_poisson2.html) | perform poisson sampling over a rectangle area.
[**pp/pp_poisson3**(size, r[, start, k, seed])](https://openhome.cc/eGossip/OpenSCAD/lib3x-pp_poisson3.html) | perform poisson sampling over a cube space.

## Maze

 Signature | Description
--|--
[**maze/mz_square**([rows, columns, start, init_cells, x_wrapping, y_wrapping, seed])](https://openhome.cc/eGossip/OpenSCAD/lib3x-mz_square.html) | return cell data of a square maze.
[**maze/mz_squarewalls**(cells, cell_width[, left_border, bottom_border])](https://openhome.cc/eGossip/OpenSCAD/lib3x-mz_squarewalls.html) | a helper for creating square wall data from maze cells.
[**maze/mz_hexwalls**(cells, cell_radius[, left_border, bottom_border])](https://openhome.cc/eGossip/OpenSCAD/lib3x-mz_hexwalls.html) | a helper for creating hex wall data from maze cells.
[**maze/mz_theta**(rings, beginning_number[, start, seed])](https://openhome.cc/eGossip/OpenSCAD/lib3x-mz_theta.html) | return cell data of a theta maze.
[**maze/mz_tiles**(cells[, left_border, bottom_border])](https://openhome.cc/eGossip/OpenSCAD/lib3x-mz_tiles.html) | turn maze cells into tiles.


# v3.2.2

Maintenance release: bug fixes & performance improvements.

# v3.2.1

Maintenance release: bug fixes & performance improvements.

# v3.2

## Deprecated:

 Name | Description
--|--
**paths2sections** | use **rails2sections** instead.
**hull_polyline2d**, **hull_polyline3d** | use **polyline_join** instead.
**shape_starburst**, **shape_pentagram** | use **shape_star** instead.
**starburst** | use **polyhedra/star** instead.

## New parameters:

- `angle_between` adds `ccw`.

## New modules/functions:

### Matrix

## 2D/3D Function

 Signature | Description
--|--
[**rails2sections**(rails)](https://openhome.cc/eGossip/OpenSCAD/lib3x-rails2sections.html) | create sections along rails.

## Transformation

 Signature | Description
--|--
[**select**(i)](https://openhome.cc/eGossip/OpenSCAD/lib3x-select.html) | select module objects.
[**polyline_join**(points)](https://openhome.cc/eGossip/OpenSCAD/lib3x-polyline_join.html) | place a join on each point. Hull each pair of joins and union all convex hulls.

## 2D Shape

 Signature | Description
--|--
[**shape_star**([outer_radius, inner_radius, n])](https://openhome.cc/eGossip/OpenSCAD/lib3x-shape_star.html) | create a 2D star.

## Polyhedra

 Signature | Description
--|--
[**polyhedra/star**([outerRadius, innerRadius, height, n])](https://openhome.cc/eGossip/OpenSCAD/lib3x-polyhedra_star.html) | create a 3D star.
[**polyhedra/polar_zonohedra**(n[, theta])](https://openhome.cc/eGossip/OpenSCAD/lib3x-polyhedra_polar_zonohedra.html) | create a [polar zonohedra](https://mathworld.wolfram.com/PolarZonohedron.html).
[**polyhedra/tetrahedron**(radius[, detail])](https://openhome.cc/eGossip/OpenSCAD/lib3x-polyhedra_tetrahedron.html) | create a tetrahedron.
[**polyhedra/hexahedron**(radius[, detail])](https://openhome.cc/eGossip/OpenSCAD/lib3x-polyhedra_hexahedron.html) | create a hexahedron.
[**polyhedra/octahedron**(radius[, detail])](https://openhome.cc/eGossip/OpenSCAD/lib3x-polyhedra_octahedron.html) | create a octahedron.
[**polyhedra/dodecahedron**(radius[, detail])](https://openhome.cc/eGossip/OpenSCAD/lib3x-polyhedra_dodecahedron.html) | create a dodecahedron.
[**polyhedra/icosahedron**(radius[, detail])](https://openhome.cc/eGossip/OpenSCAD/lib3x-polyhedra_icosahedron.html) | create a icosahedron.
[**polyhedra/superellipsoid**(radius[, detail])](https://openhome.cc/eGossip/OpenSCAD/lib3x-polyhedra_superellipsoid.html) | create a superellipsoid.

# v3.1

## Deprecated:

 Name | Description
--|--
**bezier_surface** | use **surface/sf_splines** instead.
**function_grapher** | use **surface/sf_thicken** instead.

## New modules/functions:

### Matrix

 Signature | Description
--|--
[**maxtrix/m_transpose**(m)](https://openhome.cc/eGossip/OpenSCAD/lib3x-m_transpose.html) | transpose a matrix.

### Surface

 Signature | Description
--|--
[**surface/sf_curve**(levels, curve_path, ...)](https://openhome.cc/eGossip/OpenSCAD/lib3x-sf_curve.html) | curve a photo.
[**surface/sf_splines**(ctrl_pts, row_spline, column_spline)](https://openhome.cc/eGossip/OpenSCAD/lib3x-sf_splines.html) | generalized-spline surface.
[**surface/sf_thicken**(points, thickness, ...)](https://openhome.cc/eGossip/OpenSCAD/lib3x-sf_thicken.html) | thicken a surface.
[**surface/sf_solidifyT**(points1, points2, triangles)](https://openhome.cc/eGossip/OpenSCAD/lib3x-sf_solidifyT.html) | solidify two surfaces with triangular mesh.
[**surface/sf_thickenT**(points, thickness, ...)](https://openhome.cc/eGossip/OpenSCAD/lib3x-sf_thickenT.html) | thicken a surface with triangular mesh.

### Triangle

 Signature | Description
--|--
[**triangle/tri_circumcenter**(shape_pts)](https://openhome.cc/eGossip/OpenSCAD/lib3x-tri_circumcenter.html) | return the circumcenter of a triangle.
[**triangle/tri_incenter**(shape_pts)](https://openhome.cc/eGossip/OpenSCAD/lib3x-tri_incenter.html) | return the incenter of a triangle.
[**triangle/tri_ear_clipping**(shape_pts,  ret = "TRI_INDICES", ...)](https://openhome.cc/eGossip/OpenSCAD/lib3x-tri_ear_clipping.html) | triangulation by [ear clipping](https://en.wikipedia.org/wiki/Polygon_triangulation#Ear_clipping_method).
[**triangle/tri_delaunay**(points, ret = "TRI_INDICES")](https://openhome.cc/eGossip/OpenSCAD/lib3x-tri_delaunay.html) | Join a set of points to make a [Delaunay triangulation](https://en.wikipedia.org/wiki/Delaunay_triangulation).
[**triangle/tri_delaunay_indices**(d)](https://openhome.cc/eGossip/OpenSCAD/lib3x-tri_delaunay_indices.html) | return triangle indices from a delaunay object.
[**triangle/tri_delaunay_shapes**(d)](https://openhome.cc/eGossip/OpenSCAD/lib3x-tri_delaunay_shapes.html) | return triangle shapes from a delaunay object.
[**triangle/tri_delaunay_voronoi**(d)](https://openhome.cc/eGossip/OpenSCAD/lib3x-tri_delaunay_voronoi.html) | return [Voronoi](https://en.wikipedia.org/wiki/Voronoi_diagram) cells from a delaunay object.

# v3.0

**It's a version that Breaks Backward Compatibility!!**

This version removed all deprecated modules/functions in previous versions. 

Function signature changed:
- [function_grapher](https://openhome.cc/eGossip/OpenSCAD/lib3x-function_grapher.html): delete `slicing` parameter. 
- [hull_polyline3d](https://openhome.cc/eGossip/OpenSCAD/lib3x-hull_polyline3d.html): Rename the parameter `thickness` to `diameter`.
- [line3d](https://openhome.cc/eGossip/OpenSCAD/lib3x-line3d.html): Rename the parameter `thickness` to `diameter`.
- [polyline3d](https://openhome.cc/eGossip/OpenSCAD/lib3x-polyline3d.html): Rename the parameter `thickness` to `diameter`.
- [util/bsearch](https://openhome.cc/eGossip/OpenSCAD/lib3x-bsearch.html): only supports `sorted` and `target` parameters. 
- [util/dedup](https://openhome.cc/eGossip/OpenSCAD/lib3x-dedup.html): delete `sorted` parameter. add the `eq`,`hash` and `number_of_buckets` parameters.

Deleted:
- `m_cumulate` deleted.
- `trianglate` deleted.
- `turtle/turtle2d` and `turtle/turtle3d` are used internally.

**This version, however, has some new features.**

Enhanced:
- [lines_intersection](https://openhome.cc/eGossip/OpenSCAD/lib3x-lines_intersection.html): Supports 3D lines.
- [util/sort](https://openhome.cc/eGossip/OpenSCAD/lib3x-sort.html): `by` accepts a function literal.
- [util/zip](https://openhome.cc/eGossip/OpenSCAD/lib3x-zip.html): Adds the `combine` parameter.
- [function_grapher](https://openhome.cc/eGossip/OpenSCAD/lib3x-function_grapher.html): `"LINES"`、`"HULL_LINES"` performance improved.
- [vx_union](https://openhome.cc/eGossip/OpenSCAD/lib3x-vx_union.html), [vx_circle](https://openhome.cc/eGossip/OpenSCAD/lib3x-vx_circle.html), [vx_bezier](https://openhome.cc/eGossip/OpenSCAD/lib3x-vx_bezier.html), [vx_polygon](https://openhome.cc/eGossip/OpenSCAD/lib3x-polygon.html): Performance improved.
- [util/dedup](https://openhome.cc/eGossip/OpenSCAD/lib3x-dedup.html): Performance improved.

New modules/functions:
- [angle_between](https://openhome.cc/eGossip/OpenSCAD/lib3x-angle_between.html)
- [util/degrees](https://openhome.cc/eGossip/OpenSCAD/lib3x-degrees.html)
- [util/radians](https://openhome.cc/eGossip/OpenSCAD/lib3x-radians.html)
- [util/polar_coordinate](https://openhome.cc/eGossip/OpenSCAD/lib3x-polar_coordinate.html)
- [util/spherical_coordinate](https://openhome.cc/eGossip/OpenSCAD/lib3x-spherical_coordinate.html)
- [util/every](https://openhome.cc/eGossip/OpenSCAD/lib3x-every.html)
- [util/some](https://openhome.cc/eGossip/OpenSCAD/lib3x-some.html)
- [util/swap](https://openhome.cc/eGossip/OpenSCAD/lib3x-swap.html)
- [util/shuffle](https://openhome.cc/eGossip/OpenSCAD/lib3x-shuffle.html)
- [util/find_index](https://openhome.cc/eGossip/OpenSCAD/lib3x-find_index.html)
- [util/set/hashset](https://openhome.cc/eGossip/OpenSCAD/lib3x-hashset.html)
- [util/set/hashset_add](https://openhome.cc/eGossip/OpenSCAD/lib3x-hashset_add.html)
- [util/set/hashset_has](https://openhome.cc/eGossip/OpenSCAD/lib3x-hashset_has.html)
- [util/set/hashset_del](https://openhome.cc/eGossip/OpenSCAD/lib3x-hashset_del.html)
- [util/set/hashset_len](https://openhome.cc/eGossip/OpenSCAD/lib3x-hashset_len.html)
- [util/set/hashset_elems](https://openhome.cc/eGossip/OpenSCAD/lib3x-hashset_elems.html)
- [util/map/hashmap](https://openhome.cc/eGossip/OpenSCAD/lib3x-hashmap.html)
- [util/map/hashmap_put](https://openhome.cc/eGossip/OpenSCAD/lib3x-hashmap_put.html)
- [util/map/hashmap_get](https://openhome.cc/eGossip/OpenSCAD/lib3x-hashmap_get.html)
- [util/map/hashmap_del](https://openhome.cc/eGossip/OpenSCAD/lib3x-hashmap_del.html)
- [util/map/hashmap_len](https://openhome.cc/eGossip/OpenSCAD/lib3x-hashmap_len.html)
- [util/map/hashmap_keys](https://openhome.cc/eGossip/OpenSCAD/lib3x-hashmap_keys.html)
- [util/map/hashmap_values](https://openhome.cc/eGossip/OpenSCAD/lib3x-hashmap_values.html)
- [util/map/hashmap_entries](https://openhome.cc/eGossip/OpenSCAD/lib3x-hashmap_entries.html)
- [maze/mz_theta_cells](https://openhome.cc/eGossip/OpenSCAD/lib3x-mz_theta_cells.html)
- [maze/mz_theta_get](https://openhome.cc/eGossip/OpenSCAD/lib3x-mz_theta_get.html)

# v2.5

Deprecated:
- `polytransversals`
- `shape_glued2circles`. Use `shape_liquid_splitting` instead.

New modules and functions:

- 2D Module
  - [polygon_hull](https://openhome.cc/eGossip/OpenSCAD/lib2x-polygon_hull.html)

- 3D Module
  - [polyhedron_hull](https://openhome.cc/eGossip/OpenSCAD/lib2x-polyhedron_hull.html)

- Path
  - [curve](https://openhome.cc/eGossip/OpenSCAD/lib2x-curve.html)
  - [bauer_spiral](https://openhome.cc/eGossip/OpenSCAD/lib2x-bauer_spiral.html)
  - [fibonacci_lattice](https://openhome.cc/eGossip/OpenSCAD/lib2x-fibonacci_lattice.html)

- 2D Shape
  - [shape_liquid_splitting](https://openhome.cc/eGossip/OpenSCAD/lib2x-shape_liquid_splitting.html)

- Util
  - [util/lerp](https://openhome.cc/eGossip/OpenSCAD/lib2x-lerp.html)
  - [util/choose](https://openhome.cc/eGossip/OpenSCAD/lib2x-choose.html)

- Voxel
  - [voxel/vx_bezier](https://openhome.cc/eGossip/OpenSCAD/lib2x-vx_bezier.html)
  - [voxel/vx_curve](https://openhome.cc/eGossip/OpenSCAD/lib2x-vx_curve.html)
  - [voxel/vx_contour](https://openhome.cc/eGossip/OpenSCAD/lib2x-vx_contour.html)

- Maze
  - [maze/mz_square_cells](https://openhome.cc/eGossip/OpenSCAD/lib2x-mz_square_cells.html)
  - [maze/mz_square_get](https://openhome.cc/eGossip/OpenSCAD/lib2x-mz_square_get.html)
  - [maze/mz_square_walls](https://openhome.cc/eGossip/OpenSCAD/lib2x-mz_square_walls.html)
  - [maze/mz_hex_walls](https://openhome.cc/eGossip/OpenSCAD/lib2x-mz_hex_walls.html)
  - [maze/mz_square_initialize](https://openhome.cc/eGossip/OpenSCAD/lib2x-mz_square_initialize.html)
  - [maze/mz_hamiltonian](https://openhome.cc/eGossip/OpenSCAD/lib2x-mz_hamiltonian.html)

# v2.4

Deprecated:
- Pixel. Use Voxel instead.
- voronoi2d: use [voronoi/vrn2_from](https://openhome.cc/eGossip/OpenSCAD/lib2x-vrn2_from.html) instead.
- voronoi3d: use [voronoi/vrn3_from](https://openhome.cc/eGossip/OpenSCAD/lib2x-vrn3_from.html) instead.

Improved:
- polyline2d: improved middle-point drawing, support `joinStyle` parameter.
- box_extrude: added `bottom_thicnkess` parameter.

New modules and functions:
- 2D Function
  - [lines_intersection](https://openhome.cc/eGossip/OpenSCAD/lib2x-lines_intersection.html)

- Util
  - [util/sum](https://openhome.cc/eGossip/OpenSCAD/lib2x-sum.html)
  - [util/zip](https://openhome.cc/eGossip/OpenSCAD/lib2x-zip.html)

- Turtle
  - [turtle/footprints2](https://openhome.cc/eGossip/OpenSCAD/lib2x-footprints2.html)
  - [turtle/footprints3](https://openhome.cc/eGossip/OpenSCAD/lib2x-footprints3.html)
  - [turtle/lsystem2](https://openhome.cc/eGossip/OpenSCAD/lib2x-lsystem2.html)
  - [turtle/lsystem3](https://openhome.cc/eGossip/OpenSCAD/lib2x-lsystem3.html)

- Voxel
  - [voxel/vx_line](https://openhome.cc/eGossip/OpenSCAD/lib2x-vx_line.html)
  - [voxel/vx_polyline](https://openhome.cc/eGossip/OpenSCAD/lib2x-vx_polyline.html)
  - [voxel/vx_circle](https://openhome.cc/eGossip/OpenSCAD/lib2x-vx_circle.html)
  - [voxel/vx_cylinder](https://openhome.cc/eGossip/OpenSCAD/lib2x-vx_cylinder.html)
  - [voxel/vx_sphere](https://openhome.cc/eGossip/OpenSCAD/lib2x-vx_sphere.html)
  - [voxel/vx_polygon](https://openhome.cc/eGossip/OpenSCAD/lib2x-vx_polygon.html)
  - [voxel/vx_from](https://openhome.cc/eGossip/OpenSCAD/lib2x-vx_from.html)
  - [voxel/vx_ascii](https://openhome.cc/eGossip/OpenSCAD/lib2x-vx_ascii.html)
  - [voxel/vx_gray](https://openhome.cc/eGossip/OpenSCAD/lib2x-vx_gray.html)
  - [voxel/vx_union](https://openhome.cc/eGossip/OpenSCAD/lib2x-vx_union.html)
  - [voxel/vx_intersection](https://openhome.cc/eGossip/OpenSCAD/lib2x-vx_intersection.html)
  - [voxel/vx_difference](https://openhome.cc/eGossip/OpenSCAD/lib2x-vx_difference.html)

- Matrix
  - [matrix/m_determinant](https://openhome.cc/eGossip/OpenSCAD/lib2x-m_determinant.html)

- Voronoi
  - [voronoi/vrn2_from](https://openhome.cc/eGossip/OpenSCAD/lib2x-vrn2_from.html)
  - [voronoi/vrn2_space](https://openhome.cc/eGossip/OpenSCAD/lib2x-vrn2_space.html)
  - [voronoi/vrn2_cells_from](https://openhome.cc/eGossip/OpenSCAD/lib2x-vrn2_cells_from.html)
  - [voronoi/vrn2_cells_space](https://openhome.cc/eGossip/OpenSCAD/lib2x-vrn2_cells_space.html)
  - [voronoi/vrn3_from](https://openhome.cc/eGossip/OpenSCAD/lib2x-vrn3_from.html)
  - [voronoi/vrn3_space](https://openhome.cc/eGossip/OpenSCAD/lib2x-vrn3_space.html)

# v2.3
Bugfixes:
- `helix_extrude`: wrong orientation when `CLK`.

Deprecated:
- polysections: use [sweep](https://openhome.cc/eGossip/OpenSCAD/lib2x-sweep.html) instead.
- rotate_p: use [ptf_rotate](https://openhome.cc/eGossip/OpenSCAD/lib2x-ptf_rotate.html) instead.
- circle_path: use [shape_circle](https://openhome.cc/eGossip/OpenSCAD/lib2x-shape_circle.html) instead.

New modules and functions:
- 3D Module
  - [sweep](https://openhome.cc/eGossip/OpenSCAD/lib2x-sweep.html)
  - [loft](https://openhome.cc/eGossip/OpenSCAD/lib2x-loft.html)
- 2D Function
  - [contours](https://openhome.cc/eGossip/OpenSCAD/lib2x-contours.html)
- Path
  - [shape_circle](https://openhome.cc/eGossip/OpenSCAD/lib2x-shape_circle.html)
- Util
  - [util/bsearch](https://openhome.cc/eGossip/OpenSCAD/lib2x-bsearch.html)
  - [util/has](https://openhome.cc/eGossip/OpenSCAD/lib2x-has.html)
  - [util/dedup](https://openhome.cc/eGossip/OpenSCAD/lib2x-dedup.html)
  - [util/flat](https://openhome.cc/eGossip/OpenSCAD/lib2x-flat.html)
- Point transformation
  - [ptf/ptf_rotate](https://openhome.cc/eGossip/OpenSCAD/lib2x-ptf_rotate.html)
  - [ptf/ptf_x_twist](https://openhome.cc/eGossip/OpenSCAD/lib2x-ptf_x_twist.html)
  - [ptf/ptf_y_twist](https://openhome.cc/eGossip/OpenSCAD/lib2x-ptf_y_twist.html)
  - [ptf/ptf_circle](https://openhome.cc/eGossip/OpenSCAD/lib2x-ptf_circle.html)
  - [ptf/ptf_bend](https://openhome.cc/eGossip/OpenSCAD/lib2x-ptf_bend.html)
  - [ptf/ptf_ring](https://openhome.cc/eGossip/OpenSCAD/lib2x-ptf_ring.html)
  - [ptf/ptf_sphere](https://openhome.cc/eGossip/OpenSCAD/lib2x-ptf_sphere.html)
  - [ptf/ptf_torus](https://openhome.cc/eGossip/OpenSCAD/lib2x-ptf_torus.html)
- Surface
  - [surface/sf_square](https://openhome.cc/eGossip/OpenSCAD/lib2x-sf_square.html)
  - [surface/sf_bend](https://openhome.cc/eGossip/OpenSCAD/lib2x-sf_bend.html)
  - [surface/sf_ring](https://openhome.cc/eGossip/OpenSCAD/lib2x-sf_ring.html)
  - [surface/sf_sphere](https://openhome.cc/eGossip/OpenSCAD/lib2x-sf_sphere.html)
  - [surface/sf_torus](https://openhome.cc/eGossip/OpenSCAD/lib2x-sf_torus.html)
  - [surface/sf_solidify](https://openhome.cc/eGossip/OpenSCAD/lib2x-sf_solidify.html)
- Noise
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
  - [noise/nz_cell](https://openhome.cc/eGossip/OpenSCAD/lib2x-nz_cell.html)

# v2.2.1
Bugfixes:
- `util/sort`: z not sorted.

Improvements:
- Faster when the `style` of `function_grapher` is `"LINES"` or `"HULL_LINES"`.
- Dedup pixels of `pixel/px_polyline`, `pixel/px_circle`, `pixel/px_cylinder`, `pixel/px_sphere`, `pixel/px_polygon`.

# v2.2
- Bugfixes
  - `util/sort`: fix "search term not found" warning when `by` is `"idx"`.
- Better dependency management. Just `use` modules you want. Existing scripts are not required to do any change.

# v2.1
- Bugfixes
  - `bend_extrude`: fix wrong rotation.
  - `bijection_offset`: fix point order.
- New parameters.
  - `box_extrude`: new `twist` parameter.
  - `crystall_ball`: new `thickness` parameter.
- New modules and functions.
  - [bspline_curve](https://openhome.cc/eGossip/OpenSCAD/lib2-bspline_curve.html)
  - [util/rand](https://openhome.cc/eGossip/OpenSCAD/lib2-rand.html)
  - [util/fibseq](https://openhome.cc/eGossip/OpenSCAD/lib2-fibseq.html)
  - [pixel/px_from](https://openhome.cc/eGossip/OpenSCAD/lib2-px_from.html)
  - [pixel/px_ascii](https://openhome.cc/eGossip/OpenSCAD/lib2-px_ascii.html)
  - [pixel/px_gray](https://openhome.cc/eGossip/OpenSCAD/lib2-px_gray.html)
  - [part/connector_peg](https://openhome.cc/eGossip/OpenSCAD/lib2-connector_peg.html)
  - [part/cone](https://openhome.cc/eGossip/OpenSCAD/lib2-cone.html)
  - [part/joint_T](https://openhome.cc/eGossip/OpenSCAD/lib2-joint_T.html)
  - [turtle/t2d](https://openhome.cc/eGossip/OpenSCAD/lib2-t2d.html)
  - [turtle/t3d](https://openhome.cc/eGossip/OpenSCAD/lib2-t3d.html)  

# v2.0
- Use new features of OpenSCAD-2019.05 to refactor internal implementation.
- Delete the `log` module which is never used.
- Directory changed.
  - `m_cumulate`, `m_mirror`, `m_rotation`, `m_scaling`, `m_shearing` and `m_translation` are moved into the `matrix` directory.
  - `turtle2d` and `turtle3d` are moved into the `turtle` directory.
  - `parse_number`, `split_str` and `sub_str` are moved into the `util` directory.
- New modules and functions.
  - [pixel/px_line](https://openhome.cc/eGossip/OpenSCAD/lib2-px_line.html)
  - [pixel/px_polyline](https://openhome.cc/eGossip/OpenSCAD/lib2-px_polyline.html)
  - [pixel/px_circle](https://openhome.cc/eGossip/OpenSCAD/lib2-px_circle.html)
  - [pixel/px_cylinder](https://openhome.cc/eGossip/OpenSCAD/lib2-px_cylinder.html)
  - [pixel/px_sphere](https://openhome.cc/eGossip/OpenSCAD/lib2-px_sphere.html)
  - [pixel/px_polygon](https://openhome.cc/eGossip/OpenSCAD/lib2-px_polygon.html)
  - [util/reverse](https://openhome.cc/eGossip/OpenSCAD/lib2-reverse.html)
  - [util/slice](https://openhome.cc/eGossip/OpenSCAD/lib2-slice.html)
  - [util/sort](https://openhome.cc/eGossip/OpenSCAD/lib2-sort.html)  

# v1.3.3
- Bugfixes
  - `in_shape`: Wrong variable name.

# v1.3.2
- All-in-one source file.
  - You can use `include <dotSCAD.scad>;` or `use <dotSCAD.scad>;` if you really don't want to care about dependencies.

- Bugfixes
  - `along_with`: Wrong variable scope.
  
# v1.3.1
- Bugfixes
  - `in_polyline`: Wrong parameter name.
  - `in_shape`: Missing dependency.
  - `along_with`: Avoid warning when using 2D points.
  
# v1.3
- New modules:
  - [bend_extrude](https://openhome.cc/eGossip/OpenSCAD/lib-bend_extrude.html)
  - [voronoi2d](https://openhome.cc/eGossip/OpenSCAD/lib-voronoi2d.html)
  - [voronoi3d](https://openhome.cc/eGossip/OpenSCAD/lib-voronoi3d.html)

- New functions:
  - [in_shape](https://openhome.cc/eGossip/OpenSCAD/lib-in_shape.html)
  - [in_polyline](https://openhome.cc/eGossip/OpenSCAD/lib-in_polyline.html)
  - [midpt_smooth](https://openhome.cc/eGossip/OpenSCAD/lib-midpt_smooth.html)
  - [trim_shape](https://openhome.cc/eGossip/OpenSCAD/lib-trim_shape.html)
  - [triangulate](https://openhome.cc/eGossip/OpenSCAD/lib-triangulate.html)

- New parameters:
  - `distance` of [shape_taiwan](https://openhome.cc/eGossip/OpenSCAD/lib-shape_taiwan.html)
  - `epsilon` of [bijection_offset](https://openhome.cc/eGossip/OpenSCAD/lib-bijection_offset.html)
  - `method` of [path_extrude](https://openhome.cc/eGossip/OpenSCAD/lib-path_extrude.html)
  - `method` of [along_with](https://openhome.cc/eGossip/OpenSCAD/lib-along_with.html)
   
# v1.2
- New modules and functions:
  - [starburst](https://openhome.cc/eGossip/OpenSCAD/lib-starburst.html)
  - [torus_knot](https://openhome.cc/eGossip/OpenSCAD/lib-torus_knot.html)
  - [bijection_offset](https://openhome.cc/eGossip/OpenSCAD/lib-bijection_offset.html)
  - [path_scaling_sections](https://openhome.cc/eGossip/OpenSCAD/lib-path_scaling_sections.html)

- Others
  - Avoid warnings when using newer versions of OpenSCAD after 2015.03.

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