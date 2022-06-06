# ptf_torus

Transforms a point inside a rectangle to a point of a torus. It can create things such as [torus maze](https://github.com/JustinSDK/dotSCAD/blob/master/examples/maze/torus_maze.scad).

![ptf_torus](images/lib3x-ptf_torus-1.JPG)

**Since:** 2.3

## Parameters

- `size` : 2 value array `[x, y]`, rectangle with dimensions `x` and `y`.
- `point` : The point to be transformed.
- `radius` : Torus `[R, r]`.
- `angle` : Torus `[A, a]`.
- `twist` : The number of degrees of through which the rectangle is twisted.

## Examples

    use <polyline_join.scad>
    use <ptf/ptf_torus.scad>

    size = [20, 10];
    radius = [10, 5];
    angle = [180, 180];
    twist = 90;

    rows = [
        for(y = [0:size.y])
            [for(x = [0:size.x]) [x, y]]
    ];

    columns = [
        for(x = [0:size.x])
            [for(y = [0:size.y]) [x, y]]
    ];

    for(line = rows) {
        transformed = [for(p = line) ptf_torus(size, p, radius, angle, twist)];
        polyline_join(transformed)
		    sphere(.25);
    }

    for(line = columns) {
        transformed = [for(p = line) ptf_torus(size, p, radius, angle, twist)];
        polyline_join(transformed)
		    sphere(.25);
    }

![ptf_torus](images/lib3x-ptf_torus-2.JPG)
