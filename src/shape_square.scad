/**
* shape_square.scad
*
* Returns shape points and triangle indexes of a rounded square or rectangle.
* They can be used with xxx_extrude modules of dotSCAD.
* The shape points can be also used with the built-in polygon module. 
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-shape_square.html
*
**/

function shape_square(size, corner_r = 0) = 
    let(
        frags = $fn > 0 ? 
            ($fn >= 3 ? $fn : 3) : 
            max(min(360 / $fa, corner_r * 6.28318 / $fs), 5),
        remain = frags % 4,
        corner_frags = (remain / 4) > 0.5 ? frags - remain + 4 : frags - remain,
        step_a = 360 / corner_frags,
        x = len(size) == undef ? size : size[0],
        y = len(size) == undef ? size : size[1],
        half_x = x / 2,
        half_y = y / 2, 
        half_w = half_x - corner_r,
        half_h = half_y - corner_r,
        shape_pts = concat(
            [[half_x, -half_h], [half_x, half_h]],
            [for(a = [step_a:step_a:90 - step_a]) [corner_r * cos(a) + half_w, corner_r * sin(a) + half_h]],
            [[half_w, half_y], [-half_w, half_y]],
            [for(a = [90 + step_a:step_a:180 - step_a]) [corner_r * cos(a) - half_w, corner_r * sin(a) + half_h]], 
            [[-half_x, half_h], [-half_x, -half_h]],
            [for(a = [180 + step_a:step_a:270 - step_a]) [corner_r * cos(a) - half_w, corner_r * sin(a) - half_h]],
            [[-half_w, -half_y], [half_w, -half_y]],
            [for(a = [270 + step_a:step_a:360 - step_a]) [corner_r * cos(a) + half_w, corner_r * sin(a) - half_h]]
        ),
        triangles = [for(i = [1:len(shape_pts) - 2]) [0, i, i + 1]]
    )
    [
       shape_pts,
       triangles
    ];