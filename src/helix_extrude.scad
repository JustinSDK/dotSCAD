/**
* helix_extrude.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib2x-helix_extrude.html
*
**/

use <__comm__/__frags.scad>;
use <helix.scad>;
use <cross_sections.scad>;
use <sweep.scad>;

module helix_extrude(shape_pts, radius, levels, level_dist, 
                     vt_dir = "SPI_DOWN", rt_dir = "CT_CLK", 
                     twist = 0, scale = 1.0, triangles = "SOLID") {                       
    is_flt = is_num(radius);
    r1 = is_flt ? radius : radius[0];
    r2 = is_flt ? radius : radius[1];
    
    init_r = vt_dir == "SPI_DOWN" ? r2 : r1;

    frags = __frags(init_r);

    v_dir = vt_dir == "SPI_UP" ? 1 : -1;
    r_dir = rt_dir == "CT_CLK" ? 1 : -1;
            
    angle_step = 360 / frags * r_dir;
    initial_angle = atan2(level_dist / frags, PI * 2 * init_r / frags) * v_dir * r_dir + 
                    v_dir == "SPI_DOWN" && r_dir == "CLK" ? 45 : 0;

    path_points = helix(
        radius = radius, 
        levels = levels, 
        level_dist = level_dist, 
        vt_dir = vt_dir, 
        rt_dir = rt_dir
    );

    clk_a = r_dir == 1 ? 0 : 180;
    ax = 90 + initial_angle;
    angles = [
        for(i = 0; i < len(path_points); i = i + 1) 
            [ax, 0, clk_a + angle_step * i]
    ];
    
    sections = cross_sections(shape_pts, path_points, angles, twist, scale);

    sweep(
        sections,
        triangles = triangles
    );
    
    // hook for testing
    test_helix_extrude(sections);
}

// override it to test
module test_helix_extrude(sections) {

}