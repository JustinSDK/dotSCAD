// NO_WALL = 0;       
// Y_WALL = 1;    
// X_WALL = 2;    
// Y_X_WALL = 3; 
// Z_WALL = 4;
// Z_Y_WALL = 5;    
// Z_X_WALL = 6;    
// Z_Y_X_WALL = 7; 
// MASK = 8; 

function no_wall(cell) = get_type(cell) == 0;
function y_wall(cell) = get_type(cell) == 1;
function x_wall(cell) = get_type(cell) == 2;
function y_x_wall(cell) = get_type(cell) == 3;
function z_wall(cell) = get_type(cell) == 4;
function z_y_wall(cell) = get_type(cell) == 5;
function z_x_wall(cell) = get_type(cell) == 6;
function z_y_x_wall(cell) = get_type(cell) == 7;

function cell(x, y, z, type, visited) = [x, y, z, type, visited];
function get_x(cell) = cell.x;
function get_y(cell) = cell.y;
function get_z(cell) = cell.z;
function get_type(cell) = cell[3];