use <polyline_join.scad>
use <bezier_curve.scad>
use <maze/mz_square.scad>
use <maze/mz_square_get.scad>
use <shape_circle.scad>
use <angle_between.scad>
use <polyhedra/octahedron.scad>

$fn = 36;
t_step = 0.04;
radius = 50;
thickness = 1.5;
wall_detail = 0;

maze_vase();

module maze_vase() {
    p0 = [radius * 0.75, 0, 0];
    p1 = [radius * 2, 0, radius * 1.2];
    p2 = [0, 0, radius * 1.2 * 2];
    p3 = [radius, 0, radius * 1.2 * 3];

    points = bezier_curve(t_step, [p0, p1, p2, p3]);

    rows = len(points) - 2;
    columns = $fn;

    angles = [
        for(i = [0:rows]) 
        angle_between([points[i].x + radius * 10, 0, points[i].z] - points[i], points[i + 1] - points[i])
    ];
    
    wall_r = thickness * 2;
    cells = mz_square(rows, columns, x_wrapping = true);
    a_step = 360 / $fn;
    
    for(row = cells, cell = row) {
        x = mz_square_get(cell, "x");
        y = mz_square_get(cell, "y");
        type = mz_square_get(cell, "t");

        if(type == "TOP_WALL" || type == "TOP_RIGHT_WALL") {
            p = points[y + 1];
            a = angles[y + 1];
            
            hull() {
                rotate(x * a_step)
                translate(p)
                rotate([0, -a, 0])
                    octahedron(wall_r, wall_detail);
                
                rotate((x + 1) * a_step)
                translate(p)
                rotate([0, -a, 0])
                    octahedron(wall_r, wall_detail);
            }
        }
        
        if(type == "RIGHT_WALL" || type == "TOP_RIGHT_WALL") {
            p1 = points[y];
            p2 = points[y + 1];
            a1 = angles[y];
            a2 = angles[y + 1];

            rotate((x + 1) * a_step)
            hull() {
                translate(p1)
                rotate([0, -a1, 0])
                    octahedron(wall_r, wall_detail);
                
                translate(p2)
                rotate([0, -a2, 0])
                    octahedron(wall_r, wall_detail);
            }
        }
    }

    translate([0, 0, -wall_r])
    linear_extrude(thickness * 2, scale = 1.02)
    hull()
        polygon(shape_circle(p0.x + thickness * .75));

    color("black")
    rotate_extrude()
    polyline_join([for(i = [0:rows]) [points[i].x, points[i].z]])
        circle(thickness, $fn = $fn / 4);
}