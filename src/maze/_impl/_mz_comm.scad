// NO_WALL = 0;       
// TOP_WALL = 1;    
// RIGHT_WALL = 2;    
// TOP_RIGHT_WALL = 3; 
// MASK = 4;

function no_wall(cell) = get_wall_type(cell) == 0;
function top_wall(cell) = get_wall_type(cell) == 1;
function right_wall(cell) = get_wall_type(cell) == 2;
function top_right_wall(cell) = get_wall_type(cell) == 3;

function cell(x, y, wall_type, visited) = [x, y, wall_type, visited];
function get_x(cell) = cell[0];
function get_y(cell) = cell[1];
function get_wall_type(cell) = cell[2];