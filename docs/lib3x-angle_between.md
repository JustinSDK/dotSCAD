# angle_between

Returns the angle between two vectors.

**Since:** 3.0

## Parameters

- `vt1` : vector 1.
- `vt2` : vector 2.

## Examples

    use <angle_between.scad>

    assert(angle_between([0, 1], [1, 0]) == 90);
    assert(angle_between([0, 1, 0], [1, 0, 0]) == 90);
    assert(round(angle_between([1, 1, 0], [1, 1, sqrt(2)])) == 45);