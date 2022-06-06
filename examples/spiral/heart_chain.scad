use <archimedean_spiral.scad>
use <arc.scad>

chars = "3.1415926535897932384626433832795028841971693993751058209749445923078164062862089986280348253421170679821480865132823066470938446095505822317253594081284811174502841027019385211055596446229489549303819644288109756659334461284756482337867831652712019091456485669234603486104543266482133936072602491412737245870066063155881748815209209628292540917153643678925903600113305305488204665213841469519415116094330572703657595919530921861173819326117931051185480744623799627495673518857527248912279381830119491298336733624406566430860213949463952247371907021798609437027705392171762931767523846748184676694051320005681271452635608277857713427577896091736371787214684409012249534301465495853710507922796892589235420199561121290219608640344181598136297747713099605187072113499999983729780499510597317328160963185950244594553469083026425223082533446850352619311881710100031378387528865875332083814206171776691473035982534904287554687311595628638823537875937519577818577805321712268066130019278766111959092164201989";


module heart(radius, center = false) {
    rotated_angle = 45;
    diameter = radius * 2;
    
    module heart_sub_component() {
        translate([-radius * cos(rotated_angle), 0, 0]) 
        rotate(-rotated_angle) {
            circle(radius);
            translate([0, -radius, 0]) 
                square(diameter);
        }
    }
    
    offsetX = center ? 0 : radius + radius * cos(45);
    offsetY = center ? 1.5 * radius * sin(45) - 0.5 * radius : 3 * radius * sin(45);
    translate([offsetX, offsetY, 0]) {
        heart_sub_component();
        mirror([1, 0, 0]) heart_sub_component();
    }
}

module heart_with_ears(heart_width, thickness, spacing) {
    module ear(radius, thickness, spacing) {
        width = radius / 1.5;
        
        linear_extrude(thickness) 
            arc(radius, [0, 240], width, "LINE_OUTWARD");
            
        translate([0, 0, thickness + spacing]) 
        linear_extrude(thickness) 	
            arc(radius, [240, 360], width, "LINE_OUTWARD");
            
        linear_extrude(thickness * 2 + spacing) 
            arc(radius, [0, 20], width, "LINE_OUTWARD");
    }
    
	heart_radius = 0.5 * heart_width / (1 + cos(45));
	ring_radius = heart_radius / 3;
	ring_x = (heart_width / 2 + spacing) * 1.075;
    ring_y = heart_radius * sin(60);
	ring_thickness = 0.5 * (thickness - spacing);
	
	linear_extrude(thickness) 
	    heart(heart_radius, center = true);

	translate([ring_x, ring_y, 0]) 
    rotate(-40) 
        ear(ring_radius, ring_thickness, spacing); 

	translate([-ring_x, ring_y, 0]) 
    rotate(125) 
        ear(ring_radius, ring_thickness, spacing);
}

module text_heart(char, width, thickness, spacing) {
    radius = 0.5 * width / (1 + cos(45));
    half_thickness = thickness / 2;
	difference() {
		heart_with_ears(width, thickness, spacing);
		translate([0, 0, half_thickness])
        linear_extrude(half_thickness) 
        offset(-half_thickness) 
            heart(radius, center = true);
	}
	translate([0, radius / 4, half_thickness])
    linear_extrude(half_thickness)  
        text(char, font = "Arial Black", size = radius * 1.2, valign = "center", halign="center");
}

module heart_chain(chars) {
    $fn = 48;
	heart_thickness = 2.5;
	heart_width = 18;
	spacing = 0.5;
	leng = len(chars);

    points_angles = archimedean_spiral(
        arm_distance = 20,
        init_angle = 720,
        point_distance = 23.8,
        num_of_points = leng 
    ); 
    
    for(i = [0:leng - 1]) {
        pt = points_angles[i][0];
        angle = points_angles[i][1];
        translate(pt)
        rotate(angle + 90) 
            text_heart(chars[i], heart_width, heart_thickness, spacing);       
    }
}

heart_chain(chars);


