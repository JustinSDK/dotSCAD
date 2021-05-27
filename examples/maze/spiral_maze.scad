use <archimedean_spiral.scad>;
use <hull_polyline3d.scad>;
use <hull_polyline2d.scad>;

use <maze/mz_square_cells.scad>;
use <maze/mz_square_walls.scad>;

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

    walls = mz_square_walls(
                mz_square_cells(rows, columns), 
                rows, columns, cell_width
            );

    for(wall = walls) {
        hull_polyline3d([
            for(p = wall) 
                let(
                    x = p[0],
                    y = p[1],
                    cp = (pts3d[x] + pts3d[x + 1]) / 2
                )
                cp + [0, y, 0]
            ],
            wall_thickness, 
            $fn = 5
        );
    }

    translate([0, rows, 0])
    rotate([90, 0, 0])
    linear_extrude(rows)
        hull_polyline2d([for(i = [1:len(pts2d) - 2]) pts2d[i]], wall_thickness / 2);
}