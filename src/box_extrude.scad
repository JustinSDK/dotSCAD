/**
* box_extrude.scad
*
* Creates a box (container) from a 2D object.
* 
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-box_extrude.html
*
**/

module box_extrude(height, shell_thickness) {
    linear_extrude(shell_thickness)
        children();
        
    linear_extrude(height) 
        difference() {
            children();
            offset(delta = -shell_thickness) 
                children();
        }    
}

    