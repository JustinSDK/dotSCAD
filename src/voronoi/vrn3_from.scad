/**
* vrn3_from.scad
*
* @copyright Justin Lin, 2020
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-vrn3_from.html
*
**/

use <__comm__/__angy_angz.scad>;

// slow but workable

module vrn3_from(points, spacing = 1) {
    space_size = max(max(points) - min(points));
    half_space_size = 0.5 * space_size; 
    double_space_size = 2 * space_size;
    offset_leng = (spacing + space_size) * 0.5;

    function normalize(v) = v / norm(v);
    
    module space(pt) {
        intersection_for(p = [for(p = points) if(pt != p) p]) {
            ryz = __angy_angz(p, pt);

            translate((pt + p) / 2 - normalize(p - pt) * offset_leng)
            rotate([0, -ryz[0], ryz[1]]) 
                cube([space_size, double_space_size, double_space_size], center = true); 
        }
    }    
    
    for(p = points) {	
        space(p);
    }
}