/**
* voronoi3d.scad
*
* @copyright Justin Lin, 2019
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib2x-voronoi3d.html
*
**/

use <__comm__/__angy_angz.scad>;

// slow but workable

module voronoi3d(points, space_size = "auto", spacing = 1) {
    xs = [for(p = points) p[0]];
    ys = [for(p = points) abs(p[1])];
    zs = [for(p = points) abs(p[2])];

    space_size = max([max(xs) -  min(xs), max(ys) -  min(ys), max(zs) -  min(zs)]);    
    half_space_size = 0.5 * space_size; 
    offset_leng = spacing * 0.5 + half_space_size;

    function normalize(v) = v / norm(v);
    
    module space(pt) {
        intersection_for(p = points) {
            if(pt != p) {
                v = p - pt;
                ryz = __angy_angz(p, pt);

                translate((pt + p) / 2 - normalize(v) * offset_leng)
                rotate([0, -ryz[0], ryz[1]]) 
                    cube([space_size, space_size * 2, space_size * 2], center = true); 
            }
        }
    }    
    
    for(p = points) {	
        space(p);
    }
}