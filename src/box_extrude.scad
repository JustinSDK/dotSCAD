/**
* box_extrude.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-box_extrude.html
*
**/

module box_extrude(height, shell_thickness, 
                   offset_mode = "delta", chamfer = false, 
                   twist, slices, scale) {
                       
    linear_extrude(shell_thickness)
    offset(delta = -shell_thickness, chamfer = chamfer) 
        children();
   

    linear_extrude(height, twist = twist, slices = slices, scale = scale) 
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

    