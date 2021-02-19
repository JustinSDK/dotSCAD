to_do:



dotSCAD 3.0 Dev

- `function_grapher`: delete `slicing` parameter. Improve `"LINES"`、`"HULL_LINES"` performance.
- `hull_polyline3d`: Rename the parameter `thickness` to `diameter`.
- `line3d`: Rename the parameter `thickness` to `diameter`.
- `polyline3d`: Rename the parameter `thickness` to `diameter`.
- `util/sort`: `by` accepts a function literal.
- `util/bsearch`: only supports `sorted` and `target` parameters. I view it as a new function.
- `util/dedup`: add the `eq` parameter.
- `util/zip`: add the `head` parameter.

New modules/functions

- `util/degrees`
- `util/radians`
- `util/angle_between`
- `util/polar_coordinate`
- `util/spherical_coordinate`
- `util/every`
- `util/some`

- delete `m_cumulate`
- delete `trianglate`, use `tri_ear_clipping`?
