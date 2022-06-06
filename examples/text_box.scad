use <box_extrude.scad>

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
    box_extrude(height = container_height, shell_thickness = thickness) 
        minkowski_text(t, font_size, font_name, r_round_edge);
}

module text_lid(t, font_size, font_name, r_round_edge, lid_height, thickness, spacing) {
    translate([0, 0, lid_height])
    mirror([0, 0, 1])
    box_extrude(height = lid_height, shell_thickness = thickness) 
    mirror([0, 0, 1])
    offset(r = spacing + thickness) 
        minkowski_text(t, font_size, font_name, r_round_edge); 
}
 
module text_box(model_type, t, font_size, font_name, r_round_edge, container_height, lid_height, thickness, spacing) {
    if(model_type == "Both" || model_type == "Container") {
        text_container(t, font_size, font_name, r_round_edge, container_height, thickness);    
    }
    
    if(model_type == "Both" || model_type == "Lid") {
        offset_y = (font_size + r_round_edge) * 2;

        translate([0, offset_y, 0]) 
            text_lid(t, font_size, font_name, r_round_edge, lid_height, thickness, spacing);

        translate([0, offset_y, lid_height]) 
            linear_extrude(thickness) 
                text(t, size = font_size, font = font_name);
    }
}

text_box(model_type, t, font_size, font_name, r_round_edge, container_height, lid_height, thickness, spacing);