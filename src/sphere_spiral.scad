/**
* sphere_spiral.scad
*
* Creates all points and angles on the path of a spiral around a sphere. 
* It returns a vector of [[x, y, z], [ax, ay, az]]. [x, y, z] is actually
* obtained from rotating [radius, 0, 0] by [ax, ay, az].
* It depends on the rotate_p function. Remember to include rotate_p.scad first.
* 
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-sphere_spiral.html
*
**/ 

function sphere_spiral(radius, za_step, z_circles = 1, begin_angle = 0, end_angle = 0) = 
    [
        for(a = [begin_angle:za_step:90 * z_circles - end_angle]) 
            let(ra = [0, -90 + 2 * a / z_circles, a])
            [rotate_p([radius, 0, 0], ra), ra]
    ];