/**
* golden_spiral_extrude.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib2x-golden_spiral_extrude.html
*
**/

use <golden_spiral.scad>;
use <cross_sections.scad>;
use <sweep.scad>;

module golden_spiral_extrude(shape_pts, from, to, point_distance, 
                             rt_dir = "CT_CLK", twist = 0, scale = 1.0, triangles = "SOLID") {

    pts_angles = golden_spiral(
        from = from, 
        to = to, 
        point_distance = point_distance,
        rt_dir = rt_dir
    );

    pts = [for(pt_angle = pts_angles) pt_angle[0]];
    
    az = rt_dir == "CT_CLK" ? 0 : -90;
    angles = [
        for(pt_angle = pts_angles) 
            [90, 0, pt_angle[1] + az]
    ];

    sections = cross_sections(
        shape_pts, 
        pts, angles, 
        twist = twist, 
        scale = scale
    );

    sweep(
        sections,
        triangles = triangles
    );

    // testing hook
    test_golden_spiral_extrude(sections, triangles);
}

// override it to test
module test_golden_spiral_extrude(sections, triangles) {

}