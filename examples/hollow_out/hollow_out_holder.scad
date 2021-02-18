use <hull_polyline3d.scad>;
use <ptf/ptf_bend.scad>;
use <hollow_out_square.scad>;

width = 5;
columns = 30;
rows = 15;
radius = 30;
angle = 360;
diameter = 2;
    
lines = concat(
    hollow_out_square([columns, rows], width),
    [[
        for(x = [0:width:width * columns]) [x, rows * width]
    ]]
);

for(line = lines) {  
   transformed = [for(pt = line) ptf_bend([columns * width, rows * width], pt, radius, angle)];
   hull_polyline3d(transformed, diameter, $fn = 4);
}

translate([0, 0, -diameter / 2])
linear_extrude(diameter)
rotate(180 / columns)
    circle(radius + diameter / 2, $fn = columns);