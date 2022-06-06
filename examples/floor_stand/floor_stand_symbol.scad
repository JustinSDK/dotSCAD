use <util/split_str.scad>
use <multi_line_text.scad>
use <shape_taiwan.scad>
use <floor_stand.scad>

text = " Taiwan";
font = "Arial Black";
font_size = 5;
line_spacing = 7;

stand_width = 40;
stand_height = 80;
stand_thickness = 4;
stand_spacing = 0.5;

symbol_source = "DEFAULT"; // [DEFAULT, PNG, UNICODE]

/* [FOR PNG SYMBOL] */
symbol_png = ""; // [image_surface:100x100]

/* [FOR UNICODE SYMBOL] */
symbol_unicode = "X";  
symbol_font = "Webdings";
symbol_font_size = 20;  

module content(text, font, font_size, symbol_png, symbol_unicode, symbol_font, symbol_font_size, height, thickness, line_spacing) {
    half_h = height / 2;
    half_th = thickness / 2;

    translate([0, -height / 1.8, thickness]) {
        color("black") 
        linear_extrude(half_th / 2) 
        translate([0, -half_h / 3, 0]) 
            multi_line_text(
                split_str(text, " "),
                font = font,
                size = font_size,
                line_spacing = line_spacing,    
                valign = "center", 
                halign = "center"
            );

        
        if(symbol_source == "DEFAULT") {
            color("green") 
            translate([0, half_h / 5, 0]) 
            scale([0.6, 0.6, 1]) 
            linear_extrude(half_th / 2) 
                polygon(shape_taiwan(half_h * 1.5));
        }
        else if(symbol_source == "UNICODE") {                
            color("black") 
            linear_extrude(half_th / 2)             
            translate([0, half_h / 5, 0]) 
                text(symbol_unicode, font = symbol_font, size = symbol_font_size, valign = "center", halign = "center");
        } 
        else {
            symbol_png_size = 100;
            symbol_png_scale = 0.25; 
  
            color("black") 
            translate([0, half_h / 5, half_th / 4]) 
            scale([symbol_png_scale, symbol_png_scale, 1])
            difference() {       
                cube([symbol_png_size * 0.99, symbol_png_size  * 0.99, stand_thickness / 4], center = true);                        
                
                translate([0, 0, -50])
                scale([1, 1, 100]) 
                    surface(symbol_png, center = true); 
            }
        }
    }
}
        
floor_stand(stand_width, stand_height, stand_thickness, stand_spacing) 
    content(text, font, font_size, symbol_png, symbol_unicode, symbol_font, symbol_font_size, stand_height, stand_thickness, line_spacing);
