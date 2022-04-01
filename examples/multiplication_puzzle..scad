piece_side_length = 25;
// for n x n multiplication puzzle
n = 9; // [1:9]
spacing = 0.5;

same_height = "NO"; // [YES, NO]
height = 1;       // workable when same_height is "YES"

module puzzle_piece(side_length, spacing) {
	$fn = 48;

	circle_radius = side_length / 10;
	half_circle_radius = circle_radius / 2;
    half_side_length = side_length / 2;
	side_length_div_4 = side_length / 4;
	bulge_circle_radius = circle_radius - spacing;

    circle_x = half_circle_radius - half_side_length - spacing;
    circle_y = side_length_div_4 - half_side_length;
    circle_y2 = side_length_div_4 * 3 - half_side_length;
    
    module df_circles() {
        translate([circle_x, circle_y]) 
            circle(circle_radius);
        translate([circle_x, circle_y2]) 
            circle(circle_radius);
    }
    
    module bulge_circles() {
        translate([side_length + circle_x, circle_y]) 
            circle(bulge_circle_radius);
        translate([side_length + circle_x, circle_y2]) 
            circle(bulge_circle_radius);    
    }

    translate([half_side_length - spacing, half_side_length - spacing]) {
        difference() {
            square(side_length - spacing, center = true);            
            // left
            df_circles();
            // top
            rotate(-90) 
                df_circles();       
        }

        // right
        bulge_circles();
        // bottom
        rotate(-90) 
            bulge_circles();
    }
}

module puzzle_piece_with_text(side_length, text, spacing) {
    half_side_length = side_length / 2;
	
    difference() {
		puzzle_piece(side_length, spacing);
		translate([half_side_length, half_side_length]) 
        rotate(-45) 
            text(text, size = side_length / 3, halign = "center", valign = "center");
	}
}

module multiplication_puzzle(n, piece_side_length, spacing, same_height = false, height = 1) {
    $fn = 48;
	circle_radius = piece_side_length / 10;
	half_circle_radius = circle_radius / 2;
	side_length_div_4 = piece_side_length / 4;
    n_minus_one = n - 1;
	
	intersection() {
		union() for(x = [0 : n_minus_one], y = [0 : n_minus_one]) {
            pos = [piece_side_length * x, piece_side_length * y];
            r = (x + 1) * (y + 1);
            linear_extrude(same_height ? height : r) union() {
                translate(pos) 
                    puzzle_piece_with_text(piece_side_length, str(r), spacing);
                    
                if(x == 0) {
                    x_offset = half_circle_radius - spacing * 2;
                    y_offset = piece_side_length * y - spacing;
                    translate([x_offset, side_length_div_4 + y_offset, 0]) 
                        circle(circle_radius);
                    translate([x_offset, side_length_div_4 * 3 + y_offset, 0]) 
                        circle(circle_radius);			
                }
                if(y == n_minus_one) {
                    x_offset = piece_side_length * x - spacing;
                    y_offset = piece_side_length * (y + 1) - half_circle_radius;
                    translate([side_length_div_4 + x_offset, y_offset]) 
                        circle(circle_radius);
                    translate([side_length_div_4 * 3 + x_offset, y_offset]) 
                        circle(circle_radius);	

                }
            }
            linear_extrude((same_height ? height : r) - 0.6) 
            translate(pos) 
                puzzle_piece(piece_side_length, spacing);
		}
		
		linear_extrude(same_height ? height : n * n) 
            square(piece_side_length * n - spacing * 1.5);
	}
}

multiplication_puzzle(n, piece_side_length, spacing, same_height == "YES", height);