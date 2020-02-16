use <experimental/mz_blocks.scad>;
use <experimental/mz_walls.scad>;

maze_rows = 8;
block_width = 2;
wall_thickness = 1;
inner_cube = false;
travel_all = true;

module cube_maze(maze_rows, block_width, wall_thickness, inner_cube, travel_all) {
    blocks_size = block_width * maze_rows;
    cube_size = blocks_size - wall_thickness;
    maze_size = blocks_size + wall_thickness;
    
    half_wall_thickness = wall_thickness / 2;
    half_cube_size = cube_size / 2;
    half_maze_size = maze_size / 2;
    
    origin = half_wall_thickness - half_maze_size;
    
    module two_mazes() {
        module one_maze() {
            blocks = mz_blocks(
                [1, 1],  
                maze_rows, maze_rows
            );

            walls = mz_walls(blocks, maze_rows, maze_rows, block_width);

            translate([origin, origin, half_cube_size]) 
                linear_extrude(wall_thickness) 
                for(wall = walls) {
                    for(i = [0:len(wall) - 2]) {
                        hull() {
                            translate(wall[i]) square(wall_thickness, center = true);
                            translate(wall[i + 1]) square(wall_thickness, center = true);
                        }
                    }
                }
        }

        one_maze();  
        rotate([180, 0, 0]) 
            one_maze();      
    }
    
    if(inner_cube) {
        cube(cube_size + 0.01, center= true);
    }

    difference() {
        union() {
            two_mazes();
            rotate([90, 0, 0]) two_mazes();
            rotate([0, 90, 0]) two_mazes();
        }
    
        if(travel_all) {
            union() {
                translate([half_maze_size - wall_thickness * 2, -half_maze_size, half_cube_size]) 
                    cube(wall_thickness);
            
                translate([half_maze_size - wall_thickness, half_maze_size - wall_thickness * 2, half_cube_size]) 
                    cube(wall_thickness);   
                
                translate([half_maze_size - wall_thickness, half_maze_size - wall_thickness, -half_cube_size]) 
                    cube(wall_thickness);
                
                translate([-half_maze_size + wall_thickness, half_maze_size - wall_thickness, -half_cube_size - wall_thickness]) 
                    cube(wall_thickness);

                translate([-half_maze_size, -half_maze_size + wall_thickness, -half_cube_size - wall_thickness]) 
                    cube(wall_thickness);        
        
                translate([-half_maze_size, -half_maze_size, half_cube_size - wall_thickness])
                    cube(wall_thickness);  
            }
        }        
    }
}

cube_maze(maze_rows, block_width, wall_thickness, inner_cube, travel_all);
