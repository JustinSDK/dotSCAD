use <hull_polyline3d.scad>;
use <util/rand.scad>;
use <experimental/tri_bisectors.scad>;
use <experimental/tf_bend.scad>;

width = 5;
columns = 30;
rows = 15;
radius = 30;
angle = 360;
thickness = 2;

function h_lines_in_square(width) = 
    let(
        w = width / 2,
        i = ceil(rand() * 10) % 2,
        tris = i == 0 ? 
                [
                    [[0, 0], [width, 0], [width, width]],
                    [[0, 0], [width, width], [0, width]]
                ] 
                :
                [
                    [[width, 0], [0, width], [0, 0]],
                    [[width, 0], [width, width], [0, width]]
                ]
    )
    concat(tri_bisectors(tris[0]), tri_bisectors(tris[1]));

function hollow_out_square(size, width) =
    let(
        columns = size[0],
        rows = size[1]
    )
    [
        for(y = [0:width:width * rows - width])
            for(x = [0:width:width * columns - width])
                for(line = h_lines_in_square(width)) 
                    [for(p = line) p + [x, y]] 
    ];
    
lines = concat(
    hollow_out_square([columns, rows], width),
    [[
        for(x = [0:width:width * columns]) [x, rows * width]
    ]]
);

for(line = lines) {  
   transformed = [for(pt = line) tf_bend([columns * width, rows * width], pt, radius, angle)];
   hull_polyline3d(transformed, thickness, $fn = 4);
}

translate([0, 0, -thickness / 2])
linear_extrude(thickness)
rotate(180 / columns)
    circle(radius + thickness / 2, $fn = columns);