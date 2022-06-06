use <polyline_join.scad>
use <triangle/tri_delaunay.scad>
use <experimental/tri_bisectors.scad>
use <ptf/ptf_bend.scad>

size = [100, 40];
pt_nums = 20;
line_diameter = 1;
radius = 15;
fn = 12;

xs = rands(0, size[0], pt_nums);
ys = rands(0, size[1], pt_nums);
half_fn = fn / 2;
dx = size[0] / fn;
dy = size[1] / half_fn;
points = [
    [0, 0], [size[0], 0], 
    [size[0], size[1]], [0, size[1]],
    each [for(i = [1:fn - 1]) [i * dx, 0]],
    each [for(i = [1:fn - 1]) [i * dx, size[1]]],
    each [for(i = [1:half_fn - 1]) [0, dy * i]],
    each [for(i = [1:half_fn - 1]) [size[0], dy * i]],    
    each [for(i = [0:len(xs) - 1]) [xs[i], ys[i]]]
];   

bisectors = [
    for(tri = tri_delaunay(points)) 
    each tri_bisectors([points[tri[0]], points[tri[1]], points[tri[2]]])
];

for(line = bisectors) {
    pts = [for(p = line) ptf_bend(size, p, radius, 360)];
    polyline_join([each pts, pts[0]])
        sphere(d = line_diameter, $fn = 4);
}