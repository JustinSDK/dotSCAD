use <hull_polyline2d.scad>;
use <experimental/pnoise_contour.scad>;

for(y = [0:2:4]) {
    for(x = [0:2:4]) {
        hull_polyline2d(pnoise_contour(x, y, noise = 0.025, steps = 200), width = .1, $fn = 4);
    }
}

translate([10, 0]) 
for(y = [0:2:4]) {
    for(x = [0:2:4]) {
        hull_polyline2d(pnoise_contour(x, y, steps = 100), width = .05, $fn = 4);
    }
}