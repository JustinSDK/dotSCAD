use <_impl/_mz_cube_initialize.scad>

function mz_cube_initialize(layers, rows, columns, mask) = 
    is_undef(mask) ? _lrc_maze(layers, rows, columns) : _mz_mask(mask);