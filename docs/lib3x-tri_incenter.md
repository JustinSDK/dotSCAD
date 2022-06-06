# tri_incenter

The `tri_incenter` function returns the incenter of a 2D triangle. 

**Since:** 3.1

## Parameters

- `shape_pts` : the vertices of a 2D or 3D triangle.

## Examples

    use <triangle/tri_incenter.scad>
   
    assert(tri_incenter([[0, 0], [15, 0], [0, 20]]) ==  [5, 5]);