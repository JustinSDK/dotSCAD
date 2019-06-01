# voronoi

Creats a [Voronoi diagram](https://en.wikipedia.org/wiki/Voronoi_diagram). The initial region for each cell is calculated automatically from the given points by the following code: 

    xs = [for(p = points) p[0]];
    ys = [for(p = points) abs(p[1])];
    region_size = max([(max(xs) -  min(xs) / 2), (max(ys) -  min(ys)) / 2]);    

**Since:** 1.3.

## Parameters

- `points` : Points for each cell. 
- `spacing` : Distance between cells. Default to 1.
- `r`, `delta`, `chamfer` : The outlines of each cell can be moved outward or inward. These parameters have the same effect as [`offset`](https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/Transformations#offset). 
- `region_type` : The initial shape for each cell can be `"square"` or `"circle"`. Default to `"square"`.

## Examples

    include <voronoi.scad>;

    xs = rands(-20, 20, 50);
    ys = rands(-20, 20, 50);

    points = [for(i = [0:len(xs) - 1]) [xs[i], ys[i]]];

    voronoi(points);
    translate([60, 0, 0]) 
        voronoi(points, region_type = "circle");

![voronoi](images/lib-voronoi-1.JPG)

    include <voronoi.scad>;
    include <hollow_out.scad>;

    xs = rands(0, 40, 50);
    ys = rands(0, 20, 50);

    points = [for(i = [0:len(xs) - 1]) [xs[i], ys[i]]];

    difference() {
        square([40, 20]);
        voronoi(points);
    }
    hollow_out(shell_thickness = 1) square([40, 20]);
    
![voronoi](images/lib-voronoi-2.JPG)