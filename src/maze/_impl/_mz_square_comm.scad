include <_mz_square_cell_constants.scad>

function no_wall(cell) = get_type(cell) == NO_WALL;
function top_wall(cell) = get_type(cell) == TOP_WALL;
function right_wall(cell) = get_type(cell) == RIGHT_WALL;
function top_right_wall(cell) = get_type(cell) == TOP_RIGHT_WALL;
function mask(cell) = get_type(cell) == MASK;

function cell(x, y, type, visited) = [x, y, type, visited];
function get_x(cell) = cell.x;
function get_y(cell) = cell.y;
function get_type(cell) = cell[2];