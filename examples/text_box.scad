model_type = "Both"; // [Both, Lid, Container]
t = "XD"; 
font_size = 30;
font_name = "Arial Black";
r_round_edge = 7;
container_height = 30;
lid_height = 10;
thickness = 1;
spacing = 0.6;


module minkowski_text(t, size, font, r_round_edge) {
    $fn = 24;
    minkowski() {
        text(t, font = font, size = size);
        circle(r_round_edge);
    }
}

module text_container(t, font_size, font_name, r_round_edge, container_height, thickness) {
    difference() {
        linear_extrude(container_height) 
            minkowski_text(t, font_size, font_name, r_round_edge);
        translate([0, 0, thickness]) 
            linear_extrude(container_height - thickness) 
                offset(r = -thickness) 
                    minkowski_text(t, font_size, font_name, r_round_edge);
    }
}

module text_lid(t, font_size, font_name, r_round_edge, container_height, lid_height, thickness, spacing) {
    translate([0, 0, lid_height - thickness]) 
        linear_extrude(thickness) 
            offset(r = spacing + thickness) 
                minkowski_text(t, font_size, font_name, r_round_edge);

    linear_extrude(lid_height) difference() {
        offset(r = spacing + thickness) 
            minkowski_text(t, font_size, font_name, r_round_edge);    
        offset(r = spacing) 
            minkowski_text(t, font_size, font_name, r_round_edge);
    }
}
 
module text_box(model_type, t, font_size, font_name, r_round_edge, container_height, lid_height, thickness, spacing) {
   
    if(model_type == "Both" || model_type == "Container") {
        text_container(t, font_size, font_name, r_round_edge, container_height, thickness);    
    }
    
    if(model_type == "Both" || model_type == "Lid") {
        offset_y = (font_size + r_round_edge) * 2;

        translate([0, offset_y, 0]) 
            text_lid(t, font_size, font_name, r_round_edge, container_height, lid_height, thickness, spacing);

        translate([0, offset_y, lid_height]) 
            linear_extrude(thickness) 
                text(t, size = font_size, font = font_name);
    }
}

text_box(model_type, t, font_size, font_name, r_round_edge, container_height, lid_height, thickness, spacing );