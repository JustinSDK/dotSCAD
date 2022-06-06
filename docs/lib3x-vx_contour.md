# vx_contour

Given a list of points that form a closed area, `vx_contour` returns the contour which encircles the area.

**Since:** 2.5

## Parameters

- `points` : A list of `[x, y]` points.

## Examples

    use <voxel/vx_ascii.scad>
    use <voxel/vx_contour.scad>

    t = "dotSCAD";

    color("white")
    linear_extrude(2)
    for(i = [0:len(t) - 1]) {
        translate([i * 8, 0]) 
        for(pt = vx_ascii(t[i])) {
            translate(pt)
                square(1, center = true);
        }
    }

    color("black")
    linear_extrude(1)
    for(i = [0:len(t) - 1]) {
        translate([i * 8, 0]) 
            polygon(vx_contour(vx_ascii(t[i])));
    }

![vx_contour](images/lib3x-vx_contour-1.JPG)
