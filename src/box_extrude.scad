/**
* box_extrude.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib2x-box_extrude.html
*
**/

module box_extrude(height, shell_thickness,
                   bottom_thickness_delta = 0.0,
                   offset_mode = "delta", chamfer = false, convexity = 3,
                   twist, slices, scale) {
                       
    linear_extrude(shell_thickness + bottom_thickness_delta, scale = scale / height * shell_thickness, convexity = convexity)
    offset(delta = -shell_thickness * 0.99999, chamfer = chamfer) 
        children();
   

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
