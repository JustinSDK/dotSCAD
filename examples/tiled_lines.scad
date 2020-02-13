use <line2d.scad>;
use <util/rand.scad>;

module tiled_lines(size, step, line_width = 1) {
    sizexy = is_num(size) ? [size, size] : size;
    s = is_undef(step) ? line_width * 2 : step;
 
    module rand_diagonal_line(x, y, size) {
        if(rand(0, 1) >= 0.5) {
            line2d([x, y], [x + size, y + size], width = line_width);
        } 
        else {
            line2d([x + size, y], [x, y + size], width = line_width);
        }
    } 
    
    for(x = [0:s:sizexy[0] - s]) {
        for(y = [0:s:sizexy[1] - s]) {
            rand_diagonal_line(x, y, s);    
        }
    }
}

size = [50, 25];
step = 2; 
line_width = 1;

tiled_lines(size, step, line_width);
