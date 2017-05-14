/**
* shape_square.scad
*
* Returns shape points of a rounded square or rectangle.
* They can be used with xxx_extrude modules of dotSCAD.
* The shape points can be also used with the built-in polygon module. 
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-shape_square.html
*
**/

include <__private__/__is_vector.scad>;
include <__private__/__frags.scad>;
include <__private__/__pie_for_rounding.scad>;

function shape_square(size, corner_r = 0) = 
    let(
        corner_frags = __frags(corner_r) / 4,
        x = __is_vector(size) ? size[0] : size,
        y = __is_vector(size) ? size[1] : size,
        half_x = x / 2,
        half_y = y / 2, 
        half_w = half_x - corner_r,
        half_h = half_y - corner_r,
        right_side = [
            for(pt = __pie_for_rounding(corner_r, -90, 0, corner_frags)) 
                [pt[0] + half_w - corner_r,  pt[1] - half_h + corner_r]
        ],        
        top_side = [
            for(pt = __pie_for_rounding(corner_r, 0, 90, corner_frags)) 
                [pt[0] + half_w - corner_r,  pt[1] + half_h - corner_r]
        ],
        left_side = [
            for(pt = __pie_for_rounding(corner_r, 90, 180, corner_frags)) 
                [pt[0] - half_w + corner_r,  pt[1] + half_h - corner_r]
        ],
        bottom_side = [
            for(pt = __pie_for_rounding(corner_r, 180, 270, corner_frags)) 
                [pt[0] - half_w + corner_r,  pt[1] - half_h + corner_r]
        ],
        shape_pts = concat(
            right_side, top_side, left_side, bottom_side
        )
    ) shape_pts;