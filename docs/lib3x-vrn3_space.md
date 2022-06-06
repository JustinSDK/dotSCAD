# vrn3_space

Create a [Voronoi diagram](https://en.wikipedia.org/wiki/Voronoi_diagram) in the first octant. You specify a space and a grid width. The center of each cell will be distributed in each grid randomly.

**Since:** 2.4

## Parameters

- `size` : 3 value array [x, y, z].
- `grid_w` : The width of each grid. 
- `seed` : Seed value for random number generator for repeatable results.
- `spacing` : Distance between cells. Default to 1.

## Examples

    use <voronoi/vrn3_space.scad>

    vrn3_space(
        size = [20, 15, 10],
        grid_w = 5
    );

![vrn3_space](images/lib3x-vrn3_space-1.JPG)
