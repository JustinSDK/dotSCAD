include <_mz_cube_constants.scad>

function no_wall(cell) = get_type(cell) == NO_WALL;
function y_wall(cell) = get_type(cell) == Y_WALL;
function x_wall(cell) = get_type(cell) == X_WALL;
function y_x_wall(cell) = get_type(cell) == Y_X_WALL;
function z_wall(cell) = get_type(cell) == Z_WALL;
function z_y_wall(cell) = get_type(cell) == Z_Y_WALL;
function z_x_wall(cell) = get_type(cell) == Z_X_WALL;
function z_y_x_wall(cell) = get_type(cell) == Z_Y_X_WALL;
function mask(cell) = get_type(cell) == MASK;

function cell(x, y, z, type, visited) = [x, y, z, type, visited];
function get_x(cell) = cell.x;
function get_y(cell) = cell.y;
function get_z(cell) = cell.z;
function get_type(cell) = cell[3];