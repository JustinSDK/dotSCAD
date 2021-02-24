/**
* box_extrude.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-box_extrude.html
*
**/

module box_extrude(height, shell_thickness,
                   bottom_thickness,
                   offset_mode = "delta", chamfer = false, convexity = 3,
                   twist, slices, scale) {

    btm_thickness = is_undef(bottom_thickness) ? shell_thickness : bottom_thickness;

    intersection() {
        linear_extrude(btm_thickness)
            square(65536, center = true); // 65536: just a large enough size to cover the children
                    
        linear_extrude(height, convexity = convexity, twist = twist, slices = slices, scale = scale) 
            children();
    }

    linear_extrude(height, convexity = convexity, twist = twist, slices = slices, scale = scale) 
        difference() {
            children();
            if(offset_mode == "delta") {
                offset(delta = -shell_thickness, chamfer = chamfer) 
                    children(); 
            } else {
                offset(r = -shell_thickness) 
                    children(); 
            } 
        }    
}
