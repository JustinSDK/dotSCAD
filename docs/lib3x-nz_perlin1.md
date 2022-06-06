# nz_perlin1

Returns the 1D [Perlin noise](https://en.wikipedia.org/wiki/Perlin_noise) value at the x coordinate.

**Since:** 2.3

## Parameters

- `x` : The x coordinate.
- `seed` : The random seed.

## Examples

    use <polyline_join.scad>
    use <util/rand.scad>
    use <noise/nz_perlin1.scad>

    seed = rand(0, 255);
    polyline_join([for(x = [0:.1:10]) [x, nz_perlin1(x, seed)]])
	    circle(.05);

![nz_perlin1](images/lib3x-nz_perlin1-1.JPG)