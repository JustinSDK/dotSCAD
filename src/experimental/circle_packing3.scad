use <triangle/tri_subdivide.scad>
use <experimental/tri_circle_packing.scad>

use <triangle/tri_delaunay.scad>


function circle_packing3(points, density = 1, min_r = 1) =
    [
        for(t = tri_delaunay(points, ret = "TRI_SHAPES"))
        each circle_packing_triangle3(t, density, min_r)
    ];
    
function circle_packing_triangle3(t, density, min_r) =
    [
        for(st = tri_subdivide(t, density))
        each tri_circle_packing(st, min_r)
    ];
    
$fn = 24;
density = 2;
min_r = 1;
points = [for(i = [0:100]) rands(-100, 100, 2)]; 


for(c = circle_packing3(points, density, min_r)) {
    translate(c[0])
        sphere(c[1]);
}    