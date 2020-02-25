# voronoi2d

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

    use <voronoi2d.scad>;

    points = [for(i = [0:50]) rands(-20, 20, 2)];

    voronoi2d(points);
    translate([60, 0, 0]) 
        voronoi2d(points, region_type = "circle");

![voronoi2d](images/lib-voronoi2d-1.JPG)

    use <voronoi2d.scad>;
    use <hollow_out.scad>;

    xs = rands(0, 40, 50);
    ys = rands(0, 20, 50);

    points = [for(i = [0:len(xs) - 1]) [xs[i], ys[i]]];

    difference() {
        square([40, 20]);
        voronoi2d(points);
    }
    hollow_out(shell_thickness = 1) square([40, 20]);
    
![voronoi2d](images/lib-voronoi2d-2.JPG)