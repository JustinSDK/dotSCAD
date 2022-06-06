# contains

If `lt` contains `elem`, this function returns `true`.

**Since:** 3.3

## Parameters

- `lt` : A list of vectors.
- `elem` : A element.

## Examples

    use <voxel/vx_circle.scad>
    use <util/contains.scad>

    pts = vx_circle(10);
    assert(contains(pts, [2, -10])); 
    assert(!contains(pts, [0, 0]));  
