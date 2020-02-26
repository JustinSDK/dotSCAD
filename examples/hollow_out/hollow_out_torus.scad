use <hull_polyline3d.scad>;
use <experimental/ptf_torus.scad>;
use <hollow_out_square.scad>;

width = 5;
columns = 10;
rows = 30;
radius = 30;
thickness = 2;
twist = 0;

lines = hollow_out_square([columns, rows], width);

for(line = lines) {  
   transformed = [for(pt = line) ptf_torus([columns * width, rows * width], pt, [radius, radius / 2], twist = twist)];
   hull_polyline3d(transformed, thickness, $fn = 4);
}

color("black")
rotate_extrude($fn = 36)
translate([radius * 1.5, 0, 0])
    circle(radius / 2);