/**
* arc.scad
*
* Create an arc. You can pass a 2 element vector to define the central angle. 
* Its $fa, $fs and $fn parameters are consistent with the circle module.
* It depends on the circular_sector module so you have to include circular_sector.scad.
* 
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-arc.html
*
**/ 

module arc(radius, angles, width, width_mode = "LINE_CROSS") {
    w_offset = width_mode == "LINE_CROSS" ? [width / 2, -width / 2] : (
        width_mode == "LINE_INWARD" ? [0, -width] : [width, 0]
    );
    
    difference() {
        circular_sector(radius + w_offset[0], angles);
        circular_sector(radius + w_offset[1], angles);
    }
}