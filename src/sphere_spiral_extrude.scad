/**
* sphere_spiral_extrude.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib2x-sphere_spiral_extrude.html
*
**/

use <cross_sections.scad>;
use <sphere_spiral.scad>;
use <sweep.scad>;

module sphere_spiral_extrude(shape_pts, radius, za_step, 
                             z_circles = 1, begin_angle = 0, end_angle = 0, vt_dir = "SPI_DOWN", rt_dir = "CT_CLK", 
                             twist = 0, scale = 1.0, triangles = "SOLID") {

    points_angles = sphere_spiral(
        radius = radius, 
        za_step = za_step,  
        z_circles = z_circles, 
        begin_angle = begin_angle, 
        end_angle = end_angle,
        vt_dir = vt_dir,
        rt_dir = rt_dir
    );

    v_clk = vt_dir == "SPI_DOWN" ? 90 : -90;
    r_clk = rt_dir == "CT_CLK" ? 0 : 180;

    points = [for(pa = points_angles) pa[0]];
    angles = [for(pa = points_angles) [pa[1][0] + v_clk, pa[1][1], pa[1][2] + r_clk]];

    sections = cross_sections(
        shape_pts, points, angles, twist = twist, scale = scale
    );

    sweep(
        sections, 
        triangles = triangles
    );

    // testing hook
    test_sphere_spiral_extrude(sections);
}

// override it to test
module test_sphere_spiral_extrude(sections) {

}