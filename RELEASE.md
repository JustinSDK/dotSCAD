> Version numbers are based on [Semantic Versioning](https://semver.org/).

# v3.0

**It's a version that Breaks Backward Compatibility!!**

This version removed all deprecated modules/functions in previous versions. 

Function signature changed:
- `function_grapher`: delete `slicing` parameter. 
- `hull_polyline3d`: Rename the parameter `thickness` to `diameter`.
- `line3d`: Rename the parameter `thickness` to `diameter`.
- `polyline3d`: Rename the parameter `thickness` to `diameter`.
- `util/bsearch`: only supports `sorted` and `target` parameters. 
- `util/dedup`: delete `sorted` parameter. add the `eq`,`hash` and `number_of_buckets` parameters.

Deleted:
- `m_cumulate` deleted.
- `trianglate` deleted.
- `turtle/turtle2d` and `turtle/turtle3d` are used internally.

**This version, however, has some new features.**

Enhanced:
- `lines_intersection`: Supports 3D lines.
- `util/sort`: `by` accepts a function literal.
- `util/zip`: Adds the `combine` parameter.
- `function_grapher`: `"LINES"`、`"HULL_LINES"` performance improved.
- `vx_union`, `vx_circle`, `vx_bezier`, `vx_polygon`: Performance improved.
- `util/dedup`: Performance improved.

New modules/functions:
- `angle_between`
- `util/degrees`
- `util/radians`
- `util/polar_coordinate`
- `util/spherical_coordinate`
- `util/every`
- `util/some`
- `util/swap`
- `util/shuffle`
- `util/find_index`
- `util/set/hashset`
- `util/set/hashset_add`
- `util/set/hashset_has`
- `util/set/hashset_del`
- `util/set/hashset_len`
- `util/set/hashset_elems`
- `util/map/hashmap`
- `util/map/hashmap_put`
- `util/map/hashmap_get`
- `util/map/hashmap_del`
- `util/map/hashmap_len`
- `util/map/hashmap_keys`
- `util/map/hashmap_values`
- `util/map/hashmap_entries`
- `maze/mz_theta_cells`
- `maze/mz_theta_get`

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