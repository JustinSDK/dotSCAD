use <hull_polyline3d.scad>;
use <rotate_p.scad>;
use <square_maze.scad>;
use <matrix/m_rotation.scad>;
use <experimental/pt2sphere.scad>;

r = 10;
rows = 24;
columns = 18;
block_width = 1;
wall_thickness = .5;   
pole_offset = block_width * 1.5;

module sphere_maze() {
    size = [rows * block_width, columns * block_width + pole_offset * 2];
    blocks = go_maze( 
        1, 1,   // starting point
        starting_maze(rows, columns),  
        rows, columns, y_circular = true
    );

    p_offset = [block_width * rows, pole_offset, 0];
    mr = m_rotation(90);

    walls = maze_walls(blocks, rows, columns, block_width, bottom_border = false);
    for(wall_pts = walls) {  
        rxpts = [
            for(p = wall_pts) 
                pt2sphere(size, mr * [p[0], p[1], 0, 0] + p_offset, r)
        ];
        hull_polyline3d(rxpts, wall_thickness, $fn = 6);
    }
}

sphere_maze();
color("black") 
rotate([0, 90, 0]) 
    sphere(r);