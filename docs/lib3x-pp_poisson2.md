# pp_poisson2

Perform poisson sampling over a rectangle area. An implementation of [Fast Poisson Disk Sampling in Arbitrary Dimensions](https://www.cs.ubc.ca/~rbridson/docs/bridson-siggraph07-poissondisk.pdf).

**Since:** 3.3

## Parameters

- `size` : The size `[x, y]` of the rectangle.
- `r` : The minimum distance between samples.
- `start` : Optional. The initial point(s). 
- `k` : Default to 30. The `k` constant of [Fast Poisson Disk Sampling in Arbitrary Dimensions](https://www.cs.ubc.ca/~rbridson/docs/bridson-siggraph07-poissondisk.pdf).
- `seed` : Optional. Seed value for random number generator for repeatable results. 

## Examples

    use <pp/pp_poisson2.scad>

    points = pp_poisson2([100, 100], 5);
    for(p = points) {
        translate(p)
            circle(1);
    }

![pp_poisson2](images/lib3x-pp_poisson2-1.JPG)