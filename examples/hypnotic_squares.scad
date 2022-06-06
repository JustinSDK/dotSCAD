use <hollow_out.scad>
use <bend_extrude.scad>
use <box_extrude.scad>

x_grids = 12;
y_grids = 5;
grid_size = 15;
final_size = 3;
line_width = 1;
fn = 12;

module hypnotic_squares(x_grids, y_grids, grid_size, final_size, line_width) {
    function random() = rands(0, 1, 1)[0];

    dirs = [-1, 0, 1];
    max_steps = ceil((grid_size - final_size) / (line_width * 2));
    start_steps = 2 + round(random() * (max_steps - 2));
    half_lw = line_width / 2;
    
    module hollow_square(x, y, size) {
        translate([x - half_lw, y - half_lw])  
        hollow_out(line_width) 
            square(size + line_width);
    }

    module draw(x, y, size, xMovement, yMovement, steps) {
        hollow_square(x, y, size);
     
        if(steps >= 0) {
            new_size = (grid_size) * (steps / start_steps) + final_size;

            new_x = x + (size - new_size) / 2;
            new_y = y + (size - new_size) / 2;
            draw(
                new_x - ((x - new_x) / (steps + 3)) * xMovement, 
                new_y - ((y - new_y) / (steps + 3)) * yMovement, 
                new_size, 
                xMovement, 
                yMovement, 
                steps - 1)
            ;
        }
    }

    rand_lt = [for(x = [0:x_grids - 1]) 
                  [for(y = [0:y_grids - 1]) rands(0, 1, 2)]
              ];
              
    module grids() {
        translate([0, half_lw]) 
            for(x = [0:x_grids - 1], y = [0:y_grids - 1]) {
                draw(
                    x * grid_size, 
                    y * grid_size, 
                    grid_size, 
                    dirs[floor(rand_lt[x][y][0] * 3)], 
                    dirs[floor(rand_lt[x][y][1] * 3)],
                    start_steps - 1
                );
            }    
    }

    bend_extrude(
        size = [grid_size * x_grids, grid_size * y_grids + line_width], 
        thickness = line_width, 
        angle = 360, 
        frags = $fn
    ) grids();
}


hypnotic_squares(x_grids, y_grids, grid_size, final_size, line_width, $fn = fn);

r = (0.5 * grid_size * x_grids / fn) / sin(180 / fn);
box_extrude(
    height = grid_size * y_grids + line_width, 
    shell_thickness  = line_width
) circle(r - line_width / 2, $fn = fn);