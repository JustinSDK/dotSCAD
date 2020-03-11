use <hull_polyline2d.scad>;
use <experimental/mz_blocks.scad>;
use <experimental/mz_walls.scad>;
use <experimental/ptf_circle.scad>;

module circle_maze(start, r_blocks, block_width, wall_thickness, origin_offset) {
    double_r_blocks = r_blocks * 2;
    blocks = mz_blocks(
        start,  
        double_r_blocks, double_r_blocks
    );

    width = double_r_blocks * block_width;
    walls = mz_walls(blocks, double_r_blocks, double_r_blocks, block_width);
    
    half_width =  width / 2;
    offset = is_undef(origin_offset) ? [-half_width, -half_width] : origin_offset;
    
    for(wall = walls) {
        for(i = [0:len(wall) - 2]) {
            p0 = ptf_circle(wall[i], offset);
            p1 = ptf_circle(wall[i + 1], offset);
            hull_polyline2d([p0, p1], width = wall_thickness);
        }
    } 
}

circle_maze(
    start = [1, 1], 
    r_blocks = 5, 
    block_width = 2, 
    wall_thickness = .75
);