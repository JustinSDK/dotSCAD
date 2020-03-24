- deprecate `polysections`, use `sweep`.
- deprecate `trianglate`, use `tri_ear_clipping`.
- deprecate `circle_path`, use `circle_shape`.
- deprecate `rotate_p`, use `ptf_rotate`.

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
- `shape_circle`
- `ptf/ptf_rotate`
- `ptf/ptf_x_twist`
- `ptf/ptf_y_twist`
- `ptf/ptf_circle`
- `ptf/ptf_bend`
- `ptf/ptf_ring`
- `ptf/ptf_sphere`
- `ptf/ptf_torus`

Bugfixes:
- `helix_extrude`: wrong orientation when CLK