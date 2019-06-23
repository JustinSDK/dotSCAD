/**
* shape_path_extend.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-path_extend.html
*
**/

include <__comm__/__to3d.scad>;
include <__comm__/__polytransversals.scad>;
include <__comm__/__reverse.scad>;

function _shape_path_extend_az(p1, p2) = 
    let(
        x1 = p1[0],
        y1 = p1[1],
        x2 = p2[0],
        y2 = p2[1]
    ) -90 + atan2((y2 - y1), (x2 - x1));

function _shape_path_first_stroke(stroke_pts, path_pts) =
    let(
        p1 = path_pts[0],
        p2 = path_pts[1],
        a = _shape_path_extend_az(p1, p2)
    )
    [
        for(p = stroke_pts)
            rotate_p(p, a) + p1
    ];    

function _shape_path_extend_stroke(stroke_pts, p1, p2, scale_step, i) =
    let(
        leng = norm(__to3d(p2) - __to3d(p1)),
        a = _shape_path_extend_az(p1, p2)
    )
    [
        for(p = stroke_pts)
            rotate_p(p * (1 + scale_step * i) + [0, leng], a) + p1
    ];
    
function _shape_path_extend_inner(stroke_pts, path_pts, leng_path_pts, scale_step) =
    [
        for(i = 1; i < leng_path_pts; i = i + 1)
            _shape_path_extend_stroke(
                stroke_pts, 
                path_pts[i - 1], 
                path_pts[i ], 
                scale_step, 
                i 
            )
    ];

function shape_path_extend(stroke_pts, path_pts, scale = 1.0, closed = false) =
    let(
        leng_path_pts = len(path_pts),
        scale_step = (scale - 1) / (leng_path_pts - 1),
        strokes = _shape_path_extend_inner(stroke_pts, path_pts, leng_path_pts, scale_step)        
    )
    closed && path_pts[0] == path_pts[leng_path_pts - 1] ? 
        __polytransversals(concat(strokes, [strokes[0]])) : 
        __polytransversals(
            concat([_shape_path_first_stroke(stroke_pts, path_pts)], strokes)
        );
        
