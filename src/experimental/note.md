- deprecate `polysections`, use `sweep`.
- deprecate `trianglate`, use `tri_ear_clipping`.
- deprecate `circle_path`, `use circle_shape`.

Category

- base
    -- util
    -- matrix
    -- convex
    -- ptf
    -- tri

- other
    -- pixel
    -- part
    -- maze
    -- pnoise
    -- voronoi
    -- sf
    -- turtle

Preview

- `sweep`
- `util/has`
- `util/dedup`
- `util/bsearch` 
- `util/sort` supports `by = "vt"`

Bugfixes:
- `helix_extrude`: wrong orientation when CLK