/**
* shape_pie.scad
*
* Returns shape points and triangle indexes of a pie (circular sector) shape.
* They can be used with xxx_extrude modules of dotSCAD.
* The shape points can be also used with the built-in polygon module. 
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-shape_pie.html
*
**/

include <__private__/__frags.scad>;
include <__private__/__triangles_radial.scad>;

function shape_pie(radius, angles) =
    let(
        frags = __frags(radius),
        a_step = 360 / frags,
        leng = radius * cos(a_step / 2),
        m = floor(angles[0] / a_step) + 1,
        n = floor(angles[1] / a_step),
        edge_r_begin = leng / cos((m - 0.5) * a_step - angles[0]),
        edge_r_end = leng / cos((n + 0.5) * a_step - angles[1]),
        shape_pts = concat(
            [[0, 0], edge_r_begin * [cos(angles[0]), sin(angles[0])]],
            [
                for(i = [m:n]) 
                    let(a = a_step * i)
                    radius * [cos(a), sin(a)]
            ],
            [edge_r_end * [cos(angles[1]), sin(angles[1])]]
        ),
        triangles = __triangles_radial(shape_pts)
    )
    [
        shape_pts,
        triangles
    ];