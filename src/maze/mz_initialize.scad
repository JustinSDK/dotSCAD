use <_impl/_mz_initialize.scad>;

function mz_initialize(row, columns, mask) = 
    is_undef(mask) ? _rc_maze(rows, columns) : _mz_mask(mask);