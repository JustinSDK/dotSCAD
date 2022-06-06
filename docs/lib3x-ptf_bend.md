# ptf_bend

Transforms a point inside a rectangle to a point of an arc.

**Since:** 2.3

## Parameters

- `size` : 2 value array `[x, y]`, rectangle with dimensions `x` and `y`.
- `point` : The point to be transformed.
- `radius` : The radius of the arc.
- `angle` : The central angle of the arc.

## Examples

    use <voxel/vx_ascii.scad>
    use <ptf/ptf_bend.scad>

    t = "dotSCAD";
    size = [len(t) * 8, 8];
    radius = 20;
    angle = 180;

    for(i = [0:len(t) - 1], pt = vx_ascii(t[i], invert = true)) {
        bended = ptf_bend(size, pt + [i * 8, 0], radius, angle);
        translate(bended)
            sphere(0.5, $fn = 24);
    }

![ptf_bend](images/lib3x-ptf_bend-1.JPG)
