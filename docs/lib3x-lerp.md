# lerp

Linear interpolate the vector v1 to v2.

**Since:** 2.5

## Parameters

- `v1` : The vector v1.
- `v2` : The vector v2.
- `amt` : The amount of interpolation. Some value between 0.0 and 1.0.

## Examples

    use <util/lerp.scad>
    
    assert(lerp([0, 0, 0], [100, 100, 100], 0.5) == [50, 50, 50]);  