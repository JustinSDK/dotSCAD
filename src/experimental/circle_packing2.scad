use <triangle/tri_subdivide.scad>
use <triangle/tri_delaunay.scad>
use <triangle/tri_incenter.scad>

function circle_packing2(points, density = 1) =
    [
        for(t = tri_delaunay(points, ret = "TRI_SHAPES"))
        each circle_packing_triangle2(t, density)
    ];
    
function circle_packing_triangle2(t, density) =
    [
        for(st = tri_subdivide(t, density))
        let(
            s1 = st[1] - st[0],
            s2 = st[2] - st[1],
            s3 = st[0] - st[2],
            leng_s1 = norm(s1),
            leng_s2 = norm(s2),
            leng_s3 = norm(s3)
        )
        [tri_incenter(st), abs(cross(s1, s2)) / (leng_s1 + leng_s2 + leng_s3)]
    ];
    
$fn = 24;
density = 4;
points = [for(i = [0:100]) rands(-100, 100, 2)]; 


for(c = circle_packing2(points, density)) {
    translate(c[0])
        sphere(c[1]);
}    