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

module rounded_cylinder(radius, h, round_r, convexity = 2, center = false) {
    is_vt = __is_vector(radius);
    r1 = is_vt ? radius[0] : radius;
    r2 = is_vt ? radius[1] : radius;
    
    function is_integer(n) = n % 1 == 0; 

    function round_frags(sector_angle) = __frags(round_r) * sector_angle / 360;

    function step_a(sector_angle, round_frags) =
        sector_angle / round_frags;
    
    b_ang = atan2(h, r1 - r2);
    b_sector_angle = 180 - b_ang;
    b_leng = r1 - round_r / tan(b_ang / 2);
    b_round_frags = round_frags(b_sector_angle);
    b_end_angle = -90 + b_sector_angle;
    
    t_sector_angle = b_ang;
    t_leng = r2 - round_r * tan(t_sector_angle / 2);
    t_round_frags = round_frags(t_sector_angle);
    
    translate(center ? [0, 0, -h/2] : [0, 0, 0]) rotate(180) rotate_extrude(convexity = convexity) 
        polygon(
            concat(
                [[0, 0], [b_leng, 0]],
                [
                    for(ang = [-90:step_a(b_sector_angle, b_round_frags):b_end_angle])
                        [
                            round_r * cos(ang) + b_leng, 
                            round_r * sin(ang) + round_r
                        ]
                ],
                is_integer(b_round_frags) ? [] : [[
                    round_r * cos(b_end_angle) + b_leng, 
                    round_r * sin(b_end_angle) + round_r
                ]],
                [
                    for(ang = [90 - t_sector_angle:step_a(t_sector_angle, t_round_frags):90])
                        [
                            round_r * cos(ang) + t_leng, 
                            round_r * sin(ang) + h - round_r
                        ]
                ],
                is_integer(t_round_frags) ? [] : [[
                    t_leng, 
                    round_r + h - round_r               
                ]],            
                [[t_leng, h], [0, h]]
            )
        );
}