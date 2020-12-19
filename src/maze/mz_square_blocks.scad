use <_impl/_mz_blocks_impl.scad>;
use <mz_square_initialize.scad>;

function mz_square_blocks(rows, columns, start = [0, 0], init_blocks, x_wrapping = false, y_wrapping = false, seed) = 
    go_maze( 
        start[0], start[1],   // starting point
        is_undef(init_blocks) ? mz_square_initialize(rows, columns) : init_blocks,  
        rows, columns, x_wrapping, y_wrapping, seed
    );
