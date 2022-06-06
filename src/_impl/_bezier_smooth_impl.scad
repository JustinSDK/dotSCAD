use <../__comm__/__to3d.scad>
use <../__comm__/__to2d.scad>
use <../__comm__/__angy_angz.scad>
use <../bezier_curve.scad>
use <../angle_between.scad>

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
    
function _corner(round_d, t_step, p1, p2, p3) =
    bezier_curve(t_step, _corner_ctrl_pts(round_d, p1, p2, p3));

function _corners(pts, round_d, t_step, leng, angle_threshold) =
    let(end_i = leng - 2)
    [
        for(i = 0; i < end_i; i = i + 1) 
        let(pi = pts[i], pi1 = pts[i + 1], pi2 = pts[i + 2])
        each angle_between(pi - pi1, pi1 - pi2) > angle_threshold ? 
                _corner(round_d, t_step, pi, pi1, pi2) : [pi1]
    ];

function _bezier_smooth_impl(path_pts, round_d, t_step, closed, angle_threshold) =
    let(
        pts = len(path_pts[0]) == 3 ? path_pts : [for(p = path_pts) __to3d(p)],
        leng = len(pts),
        first = pts[0],
        middle_pts = _corners(pts, round_d, t_step, leng, angle_threshold),
        last = pts[leng - 1],
        pth_pts = closed ?
            concat(
                _corners(
                    [last, first, pts[1]],
                    round_d, t_step, 3, angle_threshold
                ),
                middle_pts,
                _corners(
                    [pts[leng - 2], last, first],
                    round_d, t_step, 3, angle_threshold
                )  
            ) : [first, each middle_pts, last]
    ) 
    len(path_pts[0]) == 2 ? [for(p = pth_pts) __to2d(p)] : pth_pts;