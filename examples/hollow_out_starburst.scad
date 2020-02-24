use <shape_starburst.scad>;
use <hull_polyline3d.scad>;
use <experimental/tri_bisectors.scad>;

r1 = 30;
r2 = 12;
h = 10;
n = 5;
thickness = 1.75;
half = true;

module hollow_out_starburst(r1, r2, h, n, thickness, half = false) {
    star = [for(p = shape_starburst(r1, r2, n)) [p[0], p[1], 0]];
    leng = len(star);
    tris = concat(
        [for(i = [0:leng - 2]) [[0, 0, h], star[i], star[i + 1]]],
        [[[0, 0, h], star[leng - 1], star[0]]]
    );
    
    module half_star() {
        for(tri = tris) {
            hull_polyline3d(concat(tri, [tri[0]]), thickness = thickness);
            for(line = tri_bisectors(tri)) {
                hull_polyline3d(concat(line, [line[0]]), thickness = thickness);
            }
        }    
    }
    
    half_star();
    if(!half) {
        mirror([0, 0, 1]) half_star();
    }
}

hollow_out_starburst(r1, r2, h, n, thickness, half);