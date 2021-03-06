to_do:



dotSCAD 3.0 Dev

- `function_grapher`: delete `slicing` parameter. Improve `"LINES"`、`"HULL_LINES"` performance.
- `hull_polyline3d`: Rename the parameter `thickness` to `diameter`.
- `line3d`: Rename the parameter `thickness` to `diameter`.
- `polyline3d`: Rename the parameter `thickness` to `diameter`.
- `util/sort`: `by` accepts a function literal.
- `util/bsearch`: only supports `sorted` and `target` parameters. I view it as a new function.
- `util/dedup`: delete `sorted` parameter. add the `eq`,`hash` and `number_of_buckets` parameters.
- `util/zip`: add the `combine` parameter.
- `lines_intersection` supports 3D
- `vx_union`, `vx_circle`, `vx_bezier`, `vx_polygon` performance improved.

New modules/functions

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
- `maze/mz_theta_cells`
- `maze/mz_theta_get`
- `util/set/hashset` ...
- `util/map/hashmap` ...

- delete `m_cumulate`
- delete `trianglate`, use `tri_ear_clipping`?
- `turtle/turtle2d` and `turtle/turtle3d` used internally.