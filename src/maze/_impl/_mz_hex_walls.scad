use <../mz_square_get.scad>;

function _get_x(cell) = mz_square_get(cell, "x"); 
function _get_y(cell) = mz_square_get(cell, "y");
function _get_type(cell) = mz_square_get(cell, "t");

function _is_top_wall(cell) = _get_type(cell) == "TOP_WALL";
function _is_right_wall(cell) = _get_type(cell) == "RIGHT_WALL";
function _is_top_right_wall(cell) = _get_type(cell) == "TOP_RIGHT_WALL";
function _is_mask(cell) = _get_type(cell) == "MASK";

function _cell_position(cell_radius, x_cell, y_cell) =
    let(
        grid_h = 2 * cell_radius * sin(60),
        grid_w = cell_radius + cell_radius * cos(60)
    )
    [grid_w * x_cell, grid_h * y_cell + (x_cell % 2 == 0 ? 0 : grid_h / 2), 0];
    
function _hex_seg(cell_radius, begin, end) = [for(a = [begin:60:end]) 
				[cell_radius * cos(a), cell_radius * sin(a)]];
    
function _top_right(cell_radius) = _hex_seg(cell_radius, 0, 60);
function _top(cell_radius) = _hex_seg(cell_radius, 60, 120);
function _top_left(cell_radius) = _hex_seg(cell_radius, 120, 180);			
function _bottom_left(cell_radius) = _hex_seg(cell_radius, 180, 240); 
function _bottom(cell_radius) = _hex_seg(cell_radius, 240, 300);
function _bottom_right(cell_radius) = _hex_seg(cell_radius, 300, 360); 	   
  
function _right_wall(cell_radius, x_cell) = 
    (x_cell % 2 != 0) ? _bottom_right(cell_radius) : _top_right(cell_radius);

function _row_wall(cell_radius, x_cell, y_cell) =
    x_cell % 2 != 0 ? [_top_right(cell_radius), _top_left(cell_radius)] : [_bottom_right(cell_radius)];
    
function _build_cell(cell_radius, cell) = 
    let(
        x = _get_x(cell),
        y = _get_y(cell),
        walls = concat(
            _is_mask(cell) ? [] : _row_wall(cell_radius, x, y),
            [_is_top_wall(cell) || _is_top_right_wall(cell) ? _top(cell_radius) : []],
            [_is_right_wall(cell) || _is_top_right_wall(cell) ? _right_wall(cell_radius, x) : []]
        ),
        cell_p = _cell_position(cell_radius, x, y)
    )
    [
        for(wall = walls)
        if(wall != []) [for(p = wall) cell_p + p]
    ];
