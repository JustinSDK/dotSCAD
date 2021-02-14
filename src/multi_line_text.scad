/**
* multi_line_text.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-multi_line_text.html
*
**/ 
module multi_line_text(lines, line_spacing = 15, size = 10, font = "Arial", halign = "left", valign = "baseline", direction = "ltr", language = "en", script = "latin"){
    to = len(lines) - 1;
    inc = line_spacing;
    offset_y = inc * to / 2;

    for (i = [0 : to]) {
        translate([0 , -i * inc + offset_y, 0]) 
            text(lines[i], size, font = font, valign = valign, halign = halign, direction = direction, language = language, script = script);
    }
}