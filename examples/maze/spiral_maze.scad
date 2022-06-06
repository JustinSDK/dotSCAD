use <archimedean_spiral.scad>
use <polyline_join.scad>

use <maze/mz_square.scad>
use <maze/mz_squarewalls.scad>

rows = 8;
columns = 50;
wall_thickness = .75;
arm_distance = 4;

spiral_maze();

module spiral_maze() {
    cell_width = 1;
    points_angles = archimedean_spiral(
        arm_distance = arm_distance,
        init_angle = 180,
        point_distance = 1,
        num_of_points = columns + 2
    ); 

    pts2d = [for(pa = points_angles) pa[0]];
    pts3d = [for(p = pts2d) [p[0], 0, p[1]]];

    walls = mz_squarewalls(
                mz_square(rows, columns), 
                cell_width
            );

    half_thickness = wall_thickness / 2;
    
    for(wall = walls) {
	    polyline_join([
            for(p = wall) 
                let(
                    x = p[0],
                    y = p[1],
                    cp = (pts3d[x] + pts3d[x + 1]) / 2
                )
                cp + [0, y, 0]
        ]) sphere(half_thickness, $fn = 5);
    }

    translate([0, rows, 0])
    rotate([90, 0, 0])
    linear_extrude(rows)
	polyline_join([for(i = [1:len(pts2d) - 2]) pts2d[i]])
	    circle(wall_thickness / 4);
}