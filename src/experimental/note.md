to_do:

- deprecate `trianglate`, use `tri_ear_clipping`.

dotSCAD 3.0 Dev

- `function_grapher`: delete `slicing` parameter. Improve `"LINES"`、`"HULL_LINES"` performance.
- `util/sort`: `by` accepts a function literal.
- `util/bsearch`: only supports `sorted` and `target` parameters. I view it as a new function.
- `util/dedup`: add the `eq` parameter.

New modules/functions

- `degrees`
- `radians`
- `angle_between`
- `polar_coordinate`
- `spherical_coordinate`
- `util/every`
- `util/some`

