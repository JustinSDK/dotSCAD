# nz_perlin2

Returns the 2D [Perlin noise](https://en.wikipedia.org/wiki/Perlin_noise) value at the (x, y) coordinate.

**Since:** 2.3

## Parameters

- `x` : The x coordinate.
- `y` : The y coordinate.
- `seed` : The random seed.

## Examples

    use <util/rand.scad>;
    use <hull_polyline2d.scad>;
    use <surface/sf_thicken.scad>;
    use <noise/nz_perlin2.scad>;
    use <contours.scad>;

    seed = rand(0, 255);
    points = [
        for(y = [0:.1:10])
        [
            for(x = [0:.1:10])
            [x, y, nz_perlin2(x, y, seed)]
        ]
    ];

    sf_thicken(points, .1);

    translate([11, 0])
    for(isoline = contours(points, 0)) {
        hull_polyline2d(isoline, width = .1);
    }   

![nz_perlin2](images/lib3x-nz_perlin2-1.JPG)