/**
* mz_cube.scad
*
* @copyright Justin Lin, 2020
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-mz_cube.html
*
**/

use <_impl/_mz_cube_impl.scad>
use <mz_cube_initialize.scad>

function mz_cube(layers, rows, columns, start = [0, 0, 0], init_cells, x_wrapping = false, y_wrapping = false, z_wrapping = false, seed) = 
    let(
        mz = is_undef(init_cells) ? mz_cube_initialize(layers, rows, columns) : init_cells
    )
    go_maze( 
        start.x, 
        start.y,
        start.z,   
        mz,  
        len(mz),  
        len(mz[0]), 
        len(mz[0][0]), 
        x_wrapping, 
        y_wrapping, 
        z_wrapping,
        seed
    );

/*
use <experimental/mz_cube.scad>
use <experimental/mz_cube_get.scad>
use <util/has.scad>

layers = 3;
rows = 4;
columns = 5;
cell_width = 5;
wall_thickness = 3;

cells = mz_cube(layers, rows, columns);

difference() {
    translate([wall_thickness, wall_thickness, wall_thickness] * 0.95 / -2)
        cube([
            columns * cell_width + wall_thickness * .95,
            rows * cell_width + wall_thickness * .95,
            layers * cell_width + wall_thickness * .95
        ]);
        
    union() {
        for(layer = cells, row = layer, cell = row) {
            x = mz_cube_get(cell, "x");
            y = mz_cube_get(cell, "y");
            z = mz_cube_get(cell, "z");
            type = mz_cube_get(cell, "t");

            translate([x, y, z] * cell_width) {
                if(has(["Z_WALL", "Z_Y_WALL", "Z_X_WALL", "Z_Y_X_WALL"], type)) {
                    translate([0, 0, cell_width])
                        cell_wall(cell_width, wall_thickness);

                }

                if(has(["Y_WALL", "Y_X_WALL", "Z_Y_WALL", "Z_Y_X_WALL"], type)) {
                    translate([0, cell_width, 0])
                    rotate([90, 0, 0])
                         cell_wall(cell_width, wall_thickness);
                }
                
                if(has(["X_WALL", "Y_X_WALL", "Z_X_WALL", "Z_Y_X_WALL"], type)) {
                    translate([cell_width, 0, 0])
                    rotate([0, -90, 0])
                        cell_wall(cell_width, wall_thickness);
                }
            }
        }

        translate([-wall_thickness / 2, -wall_thickness / 2, -wall_thickness / 2])
            cube([cell_width * columns + wall_thickness, cell_width * rows + wall_thickness, wall_thickness]);

        translate([-wall_thickness / 2, -wall_thickness / 2, -wall_thickness / 2])
            cube([wall_thickness, cell_width * rows + wall_thickness, cell_width * layers + wall_thickness]);

        translate([-wall_thickness / 2, -wall_thickness / 2, -wall_thickness / 2])
            cube([cell_width * columns + wall_thickness, wall_thickness, cell_width * layers + wall_thickness]);
    }
}
    
module cell_wall(cell_width, wall_thickness) {
    hull() {
        cube(wall_thickness, center = true);
        
        translate([cell_width, 0])
            cube(wall_thickness, center = true);
            
        translate([cell_width, cell_width])
            cube(wall_thickness, center = true);
        
        translate([0, cell_width])
            cube(wall_thickness, center = true);
    }
}
*/
