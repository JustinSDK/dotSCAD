use <_mz_square_comm.scad>

function _cell_position(cell_radius, x_cell, y_cell) =
    let(
        grid_h = 2 * cell_radius * sin(60),
        grid_w = cell_radius + cell_radius * cos(60)
    )
    [grid_w * x_cell, grid_h * y_cell + (x_cell % 2 == 0 ? 0 : grid_h / 2), 0];
    
function _hex_seg(cell_radius, begin, end) = 
    [
        for(a = [begin:60:end]) 
		[cell_radius * cos(a), cell_radius * sin(a)]
    ];
    
function _build_top_right(cell_radius) = _hex_seg(cell_radius, 0, 60);
function _build_top(cell_radius) = _hex_seg(cell_radius, 60, 120);
function _build_top_left(cell_radius) = _hex_seg(cell_radius, 120, 180);			
function _build_bottom_left(cell_radius) = _hex_seg(cell_radius, 180, 240); 
function _build_bottom(cell_radius) = _hex_seg(cell_radius, 240, 300);
function _build_bottom_right(cell_radius) = _hex_seg(cell_radius, 300, 360); 	   
  
function _right_wall(cell_radius, x_cell) = 
    (x_cell % 2 != 0) ? _build_bottom_right(cell_radius) : _build_top_right(cell_radius);

function _row_wall(cell_radius, x_cell, y_cell) =
    x_cell % 2 != 0 ? [_build_top_right(cell_radius), _build_top_left(cell_radius)] : [_build_bottom_right(cell_radius)];
    
function _build_cell(cell_radius, cell) = 
    let(
        x = get_x(cell),
        y = get_y(cell),
        walls = [
            if(!mask(cell)) each _row_wall(cell_radius, x, y),
            if(top_wall(cell) || top_right_wall(cell)) _build_top(cell_radius),
            if(right_wall(cell) || top_right_wall(cell)) _right_wall(cell_radius, x)
        ],
        cell_p = _cell_position(cell_radius, x, y)
    )
    [
        for(wall = walls) 
        [for(p = wall) cell_p + p]
    ];
