use <hull_polyline3d.scad>;
use <matrix/m_rotation.scad>;
use <experimental/mz_blocks.scad>;
use <experimental/mz_walls.scad>;
use <experimental/ptf_sphere.scad>;

r = 10;
rows = 24;
columns = 18;
block_width = 1;
wall_thickness = .5;   
pole_offset = block_width * 1.5;

module sphere_maze() {
    size = [rows * block_width, columns * block_width + pole_offset * 2];
    blocks = mz_blocks(
        [1, 1],  
        rows, columns, 
        y_circular = true
    );

    p_offset = [block_width * rows, pole_offset, 0];
    mr = m_rotation(90);

    walls = mz_walls(blocks, rows, columns, block_width, bottom_border = false);
    for(wall_pts = walls) {  
        rxpts = [
            for(p = wall_pts) 
                ptf_sphere(size, mr * [p[0], p[1], 0, 0] + p_offset, r)
        ];
        hull_polyline3d(rxpts, wall_thickness, $fn = 6);
    }
}

sphere_maze();
color("black") 
rotate([0, 90, 0]) 
    sphere(r);