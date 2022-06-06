# tri_circumcenter

The `tri_circumcenter` function returns the circumcenter of a 2D triangle. 

**Since:** 3.1

## Parameters

- `shape_pts` : the vertices of a 2D triangle.

## Examples

    use <triangle/tri_circumcenter.scad>
   
    assert(tri_circumcenter([[0, 0], [10, 20], [15, 10]]) == [3.75, 10.625]);