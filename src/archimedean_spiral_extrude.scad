/**
* archimedean_spiral_extrude.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib2x-archimedean_spiral_extrude.html
*
**/

use <archimedean_spiral.scad>;
use <cross_sections.scad>;
use <sweep.scad>;

module archimedean_spiral_extrude(shape_pts, arm_distance, init_angle, point_distance, num_of_points, 
                                  rt_dir = "CT_CLK", twist = 0, scale = 1.0, triangles = "SOLID") {
    points_angles = archimedean_spiral(
        arm_distance = arm_distance,  
        init_angle = init_angle, 
        point_distance = point_distance,
        num_of_points = num_of_points,
        rt_dir = rt_dir
    ); 

    clk_a = rt_dir == "CT_CLK" ? 0 : 180; 

    points = [for(pa = points_angles) pa[0]];
    angles = [
        for(pa = points_angles) 
             [90, 0, pa[1] + clk_a]
    ];

    sections = cross_sections(shape_pts, points, angles, twist, scale);

    sweep(
        sections,
        triangles = triangles
    );

    // testing hook
    test_archimedean_spiral_extrude(sections); 
}   

// override it to test
module test_archimedean_spiral_extrude(sections) {

}