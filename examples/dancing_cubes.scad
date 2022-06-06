use <rounded_square.scad>
use <part/joint_T.scad>
use <shape_taiwan.scad>

rows = 3; // [2:100]
cube_width = 20;

spacing = 0.4;
shaft_r = 1.9;
edge_width = 2; 

pattern_thickness = 1.5;

dancing_cubes_with(rows, cube_width, shaft_r, spacing, edge_width, pattern_thickness, center = true)
linear_extrude(pattern_thickness) 
    polygon(shape_taiwan(cube_width * rows - edge_width));

module a_dancing_cube_no_joint(cube_width, holes, hole_radius, edge_width) {
    module part_for_carve_a_sink(hole_radius, height, edge_width) {
        module part_for_h_carving() {
            leng = hole_radius + edge_width + .1;
            rotate([0, 90, 0]) 
            linear_extrude(leng) 
                circle(hole_radius);
                
            rotate([-90, 0, 0]) 
            linear_extrude(leng) 
                circle(hole_radius);
                
            linear_extrude(2 * hole_radius, center = true) 
                square(leng);
        }

        linear_extrude(height) 
            circle(hole_radius);

        translate([0, 0, height / 4]) 
            part_for_h_carving();
            
        translate([0, 0, height * 3 / 4]) 
            part_for_h_carving();
    }

    corner_r = hole_radius + edge_width;

	module carved_parts() {
        offset_v = cube_width - corner_r;
		translate([corner_r, corner_r, 0]) 
        rotate(180) 
            part_for_carve_a_sink(hole_radius, cube_width, edge_width);
				
		translate([offset_v, corner_r, 0]) 
        rotate(270) 
            part_for_carve_a_sink(hole_radius, cube_width, edge_width);
			
        if(holes > 2) {			
			translate([offset_v, offset_v, 0]) 
            rotate(360) 
                part_for_carve_a_sink(hole_radius, cube_width, edge_width);
		} else if(holes > 3) {	
			translate([corner_r, offset_v, 0]) 
            rotate(90) 
                part_for_carve_a_sink(hole_radius, cube_width, edge_width);		
        }			
	}
    
    neg_half_w = -cube_width / 2;
	rotate(135) 
    translate([neg_half_w, neg_half_w])
	difference() {
        linear_extrude(cube_width) 
            rounded_square(cube_width, corner_r);
		carved_parts();			
	}
}

module dancing_cubes(rows, cube_width, shaft_r, spacing, edge_width, center = false) {
    $fn = 36;

    half_cube_width = cube_width / 2;
    hole_radius = shaft_r + spacing; 
	corner_r = hole_radius + edge_width;
    t_leng = edge_width + spacing + hole_radius;
	cube_offset = cube_width + spacing;
	
	function is_corner(row, column) = 
	    (row == 0 && (column == 0 || column == rows - 1)) ||
		(row == rows - 1 && (column == 0 || column == rows - 1));

	module corner_cube(row, column) {
	    a = row == 0 && column == 0 ? 0 : 
        row == 0 && column == rows - 1 ? -90 : 
		row == rows - 1 && column == 0 ? 90 : 180;
			
		rotate(a) 
		    a_dancing_cube_no_joint(cube_width, 2, hole_radius, edge_width);	
	}
	
	function is_side(row, column) = 
	    row * column == 0 || 
		row == rows - 1 || 
		column == rows - 1;
		
	module side_cube(row, column) {
        a = column == 0 ? 0 : 
        row == 0 ? -90 : 
        column == rows - 1 ? 180 : 90;
        
        rotate(a) 
            a_dancing_cube_no_joint(cube_width, 3, hole_radius, edge_width);			
	}
    
	function is_even(n) = n % 2 == 0;

    module joint_H() {
        module half_H() {
            translate([-t_leng, 0]) 
                joint_T(shaft_r, half_cube_width, t_leng, edge_width, spacing = spacing);
                
            translate([-t_leng, 0, half_cube_width]) 
                joint_T(shaft_r, half_cube_width, t_leng, edge_width, spacing = spacing);     
        }
        half_H();
        mirror([1, 0, 0]) half_H();    
    }

    center_offset = center ? (cube_width + spacing) * rows / 2 : 0;
    offset_v = half_cube_width + spacing - center_offset;
    translate([offset_v, offset_v]) {
        for(r = [0:rows - 1]) {
            for(c = [0:rows - 1]) {
                translate([cube_offset * r, cube_offset * c, 0]) 
                rotate(is_even(r + c) ? 45 : -45) {            
                    if(is_corner(r, c)) {
                        corner_cube(r, c);			
                    } else if(is_side(r, c)) {
                        side_cube(r, c);
                    } else {
                        a_dancing_cube_no_joint(cube_width, 4, hole_radius, edge_width);		
                    }	
                }
            }
        }
        
        joint_offset_x = half_cube_width - corner_r;
        joint_offset_y = spacing + half_cube_width;
        
        for(r = [0:rows - 2]) {
            for(c = [0:rows - 1]) {
                offset_c = c * cube_offset;
                offset_r = joint_offset_y + cube_offset * r;
                
                translate([
                    offset_c + (is_even(r + c) ? -joint_offset_x : joint_offset_x), 
                     offset_r
                ]) 
                rotate(90) 
                    joint_H();
                
                translate([
                    offset_r,
                    offset_c + (is_even(r + c) ? joint_offset_x : -joint_offset_x)
                ]) joint_H();
            }
        }
    
    }

}

module dancing_cubes_with(rows, cube_width, shaft_r, spacing, edge_width, pattern_thickness, center = false) {
    half_w = cube_width / 2;
	range_width = (cube_width + spacing) * rows;
    
    color("green") translate([0, 0, cube_width]) 
    intersection() {
        dancing_cubes(rows, cube_width, shaft_r, spacing, edge_width, center = center);
        
        intersection() {
            linear_extrude(pattern_thickness) 
                square(range_width, center = center);
            children();
        }            
    }

    dancing_cubes(rows, cube_width, shaft_r, spacing, edge_width, center = center);    
}


