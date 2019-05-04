
/**
* shape_glued2circles.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-shape_glued2circles.html
*
**/ 

function _glued2circles_pie_curve(radius, centre_dist, tangent_angle) =
    let(
        begin_ang = 90 + tangent_angle,
        shape_pts = shape_pie(radius, [-begin_ang, begin_ang])
    )
    [
        for(i = [1:len(shape_pts) - 1])
            shape_pts[i] + [centre_dist / 2, 0]
    ];
    
function _glued2circles_bezier(radius, centre_dist, tangent_angle, t_step, ctrl_p1) = 
    let(
        ctrl_p = rotate_p([radius * tan(tangent_angle), -radius], tangent_angle),
        ctrl_p2 = [-ctrl_p[0], ctrl_p[1]] + [centre_dist / 2, 0],
        ctrl_p3 = [-ctrl_p2[0], ctrl_p2[1]],
        ctrl_p4 = [-ctrl_p1[0], ctrl_p1[1]]            
    )
    bezier_curve(
        t_step,
        [
            ctrl_p1,
            ctrl_p2,
            ctrl_p3,
            ctrl_p4        
        ]
    );    

function _glued2circles_lower_half_curve(curve_pts, leng, i = 0) =
    i < leng ? (
        curve_pts[leng - 1 - i][0] >= 0 ? 
            concat(
                [curve_pts[leng - 1 - i]], 
                _glued2circles_lower_half_curve(curve_pts, leng, i + 1)
            ) : 
            _glued2circles_lower_half_curve(curve_pts, leng, i + 1)
    ) : [];    
    
function _glued2circles_half_glued_circle(radius, centre_dist, tangent_angle, t_step) =
    let(
        pie_curve_pts = _glued2circles_pie_curve(radius, centre_dist, tangent_angle),
        curve_pts = _glued2circles_bezier(radius, centre_dist, tangent_angle, t_step, pie_curve_pts[0]),
        lower_curve_pts = _glued2circles_lower_half_curve(curve_pts, len(curve_pts)),
        leng_half_curve_pts = len(lower_curve_pts),
        upper_curve_pts = [
            for(i = [0:leng_half_curve_pts - 1])
                let(pt = lower_curve_pts[leng_half_curve_pts - 1 - i])
                [pt[0], -pt[1]]
        ]
    ) concat(
        lower_curve_pts,
        pie_curve_pts,        
        upper_curve_pts
    );
    
function shape_glued2circles(radius, centre_dist, tangent_angle = 30, t_step = 0.1) =
    let(
        half_glued_circles = _glued2circles_half_glued_circle(radius, centre_dist, tangent_angle, t_step),
        leng_half_glued_circles = len(half_glued_circles),
        left_half_glued_circles = [
            for(i = [0:leng_half_glued_circles - 1])
                let(pt = half_glued_circles[leng_half_glued_circles - 1 - i])
                [-pt[0], pt[1]]
        ]    
    ) concat(half_glued_circles, left_half_glued_circles);