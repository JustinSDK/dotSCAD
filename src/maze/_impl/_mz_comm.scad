// NO_WALL = 0;       
// TOP_WALL = 1;    
// RIGHT_WALL = 2;    
// TOP_RIGHT_WALL = 3; 
// MASK = 4;

function no_wall(block) = get_wall_type(block) == 0;
function top_wall(block) = get_wall_type(block) == 1;
function right_wall(block) = get_wall_type(block) == 2;
function top_right_wall(block) = get_wall_type(block) == 3;

function block(x, y, wall_type, visited) = [x, y, wall_type, visited];
function get_x(block) = block[0];
function get_y(block) = block[1];
function get_wall_type(block) = block[2];