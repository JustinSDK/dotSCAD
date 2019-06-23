/**
* bezier_smooth.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-bezier_curve.html
*
**/ 

include <__comm__/__to3d.scad>;
include <__comm__/__to2d.scad>;
include <__comm__/__angy_angz.scad>;

function _corner_ctrl_pts(round_d, p1, p2, p3) =
    let(
        _ya_za_1 = __angy_angz(p1, p2),
        _ya_za_2 = __angy_angz(p3, p2),
        
        dz1 = sin(_ya_za_1[0]) * round_d,
        dxy1 = cos(_ya_za_1[0]) * round_d,
        dy1 = sin(_ya_za_1[1]) * dxy1,
        dx1 = cos(_ya_za_1[1]) * dxy1,
        
        dz2 = sin(_ya_za_2[0]) * round_d,
        dxy2 = cos(_ya_za_2[0]) * round_d,
        dy2 = sin(_ya_za_2[1]) * dxy2,
        dx2 = cos(_ya_za_2[1]) * dxy2       
    )
    [
        p2 - [dx1, dy1, dz1],
        p2,
        p2 - [dx2, dy2, dz2]
    ];
    
    
function _bezier_corner(round_d, t_step, p1, p2, p3) =
    bezier_curve(t_step, _corner_ctrl_pts(round_d, p1, p2, p3));

function _recursive_bezier_smooth(pts, round_d, t_step, leng) =
    let(end_i = leng - 2)
    [
        for(i = 0; i < end_i; i = i + 1) 
            each _bezier_corner(round_d, t_step, pts[i], pts[i + 1], pts[i + 2])
    ];

    
function bezier_smooth(path_pts, round_d, t_step = 0.1, closed = false) =
    let(
        pts = len(path_pts[0]) == 3 ? path_pts : [for(p = path_pts) __to3d(p)],
        leng = len(pts),
        middle_pts = _recursive_bezier_smooth(pts, round_d, t_step, leng),
        pth_pts = closed ?
            concat(
                _recursive_bezier_smooth(
                    [pts[leng - 1], pts[0], pts[1]],
                    round_d, t_step, 3
                ),
                middle_pts,
                _recursive_bezier_smooth(
                    [pts[leng - 2], pts[leng - 1], pts[0]],
                    round_d, t_step, 3
                )  
            ) :
            concat(
                [pts[0]],
                middle_pts,
                [pts[leng - 1]]
            )
    ) 
    len(path_pts[0]) == 2 ? [for(p = pth_pts) __to2d(p)] : pth_pts;