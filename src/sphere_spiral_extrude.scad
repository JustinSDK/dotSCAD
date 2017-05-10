/**
* sphere_spiral_extrude.scad
*
* Extrudes a 2D shape along the path of a sphere spiral.
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-sphere_spiral_extrude.html
*
**/

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

    points = [for(pa = points_angles) pa[0]];
    angles = [for(pa = points_angles) [pa[1][0] + 90, pa[1][1], pa[1][2]]];

    polysections(
        cross_sections(
            shape_pts, points, angles, twist = twist, scale = scale
        ), 
        triangles = triangles
    );
}