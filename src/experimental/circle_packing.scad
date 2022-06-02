use <experimental/tri_circle_packing.scad>;

use <triangle/tri_delaunay.scad>;

function circle_packing(points, density = 1, min_r = 1) =
    [
        for(t = tri_delaunay(points, ret = "TRI_SHAPES"))
        each tri_circle_packing(t, density, min_r)
    ];


$fn = 24;
density = 3;
min_r = 1;
points = [for(i = [0:100]) rands(-100, 100, 2)]; 

for(c = circle_packing(points, density, min_r)) {
    translate(c[0])
        sphere(c[1]);
}
