use <arc.scad>;
use <heart_maze.scad>;
use <experimental/mz_blocks.scad>;

names = ["Justin", "Monica"];
font_name = "Arial Black";
font_size = 8;

radius_of_heart = 15;
tip_r_of_heart = 5;
wall_thickness = 2.5;
cblocks = 6;
levels = 3;
spacing = 0.4;

$fn = 36;

module heart_base(name, font_name, font_size, radius, ring_thickness, tip_r_of_heart) {
    difference() {
        linear_extrude(ring_thickness)
            heart(radius, tip_r_of_heart); 
        
        linear_extrude(ring_thickness * 0.75)
        mirror([1, 0, 0]) 
            text(name, font = font_name, size = font_size, valign = "center", halign = "center");
    }

    linear_extrude(ring_thickness) 
    translate([0, radius * 1.15])
        arc(radius = radius / 3, angle = [25, 155], width = ring_thickness);        
}

module heart2heart_maze(names, font_name, font_size, radius_of_heart, tip_r_of_heart, wall_thickness, cblocks, levels, spacing) {
    maze = mz_blocks(
	    [1, 1],  
	    cblocks, levels, y_circular = true
    );

    translate([0, 0, wall_thickness])
    linear_extrude(wall_thickness)
        heart_maze(maze, radius_of_heart, cblocks, levels, wall_thickness);
    heart_base(names[0], font_name, font_size, radius_of_heart + wall_thickness / 2, wall_thickness, tip_r_of_heart);

    translate([radius_of_heart * 4, 0, 0]) {
        heart_base(names[1], font_name, font_size, radius_of_heart + wall_thickness / 2, wall_thickness, tip_r_of_heart);   
        
        translate([0, 0, wall_thickness])
        mirror([1, 0, 0]) 
        difference() {
            linear_extrude(wall_thickness)
                heart(radius_of_heart, tip_r_of_heart); 
            linear_extrude(wall_thickness * 2)
            offset(delta = spacing)
                heart_maze(maze, radius_of_heart, cblocks, levels, wall_thickness);
        }
    }
}

heart2heart_maze(names, font_name, font_size, radius_of_heart, tip_r_of_heart, wall_thickness, cblocks, levels, spacing);