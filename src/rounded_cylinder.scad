/**
* rounded_cylinder.scad
*
* Creates a rounded cylinder. 
* 
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-rounded_cylinder.html
*
**/

include <__private__/__is_vector.scad>;
include <__private__/__frags.scad>;

module rounded_cylinder(radius, h, round_r, convexity = 2, center = false, slices = undef) {
    is_vt = __is_vector(radius);
    r1 = is_vt ? radius[0] : radius;
    r2 = is_vt ? radius[1] : radius;
    
    function step_a(sector_angle) =
        sector_angle / (slices == undef ? __frags(round_r) * sector_angle / 360 : slices);
    
    b_ang = atan2(h, r1 - r2);
    b_sector_angle = 180 - b_ang;
    b_leng = r1 - round_r / tan(b_ang / 2);
    
    t_sector_angle = b_ang;
    t_leng = r2 - round_r * tan(t_sector_angle / 2);
    
    translate(center ? [0, 0, -h/2] : [0, 0, 0]) rotate_extrude(convexity = convexity) 
        polygon(
            concat(
                [[0, 0], [b_leng, 0]],
                [
                    for(ang = [-90:step_a(b_sector_angle):-90 + b_sector_angle])
                        [
                            round_r * cos(ang) + b_leng, 
                            round_r * sin(ang) + round_r
                        ]
                ],
                [
                    for(ang = [90 - t_sector_angle:step_a(t_sector_angle):90])
                        [
                            round_r * cos(ang) + t_leng, 
                            round_r * sin(ang) + h - round_r
                        ]
                ],            
                [[t_leng, h], [0, h]]
            )
        );
}