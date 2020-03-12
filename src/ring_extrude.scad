/**
* ring_extrude.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib2x-ring_extrude.html
*
**/

use <__comm__/__frags.scad>;
use <__comm__/__ra_to_xy.scad>;
use <cross_sections.scad>;
use <sweep.scad>;

module ring_extrude(shape_pts, radius, angle = 360, twist = 0, scale = 1.0, triangles = "SOLID") {
    if(twist == 0 && scale == 1.0) {
        rotate_extrude(angle = angle) 
        translate([radius, 0, 0]) 
            polygon(shape_pts);
    } else {
        a_step = 360 / __frags(radius);

        angles = is_num(angle) ? [0, angle] : angle;

        m = floor(angles[0] / a_step) + 1;
        n = floor(angles[1] / a_step);

        leng = radius * cos(a_step / 2);

        begin_r = leng / cos((m - 0.5) * a_step - angles[0]);
        end_r =  leng / cos((n + 0.5) * a_step - angles[1]);

        angs = concat(
            [[90, 0, angles[0]]], 
            m > n ? [] : [for(i = [m:n]) [90, 0, a_step * i]]
        );
        pts = concat(
            [__ra_to_xy(begin_r, angles[0])],
            m > n ? [] : [for(i = [m:n]) __ra_to_xy(radius, a_step * i)]
        ); 

        is_angle_frag_end = angs[len(angs) - 1][2] == angles[1];
        
        all_angles = is_angle_frag_end ? 
            angs :  
            concat(angs, [[90, 0, angles[1]]]);
            
        all_points = is_angle_frag_end ? 
            pts :
            concat(pts, [__ra_to_xy(end_r, angles[1])]);

        sections = cross_sections(shape_pts, all_points, all_angles, twist, scale);

        sweep(
            sections,
            triangles = triangles
        );

        // hook for testing
        test_ring_extrude(sections, angle);
    }
}

// Override it to test
module test_ring_extrude(sections, angle) {

}