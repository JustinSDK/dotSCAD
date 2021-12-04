use <../ptf/ptf_rotate.scad>;
use <../shape_pie.scad>;
use <../bezier_curve.scad>;

function _liquid_splitting_pie_curve(radius, centre_dist, tangent_angle) =
    let(
        begin_ang = 90 + tangent_angle,
        shape_pts = shape_pie(radius, [-begin_ang, begin_ang]),
        leng = len(shape_pts)
    )
    [
        for(i = 1; i < leng; i = i + 1)
            shape_pts[i] + [centre_dist / 2, 0]
    ];
    
function _liquid_splitting_bezier(radius, centre_dist, tangent_angle, t_step, ctrl_p1) = 
    let(
        ctrl_p = ptf_rotate([radius * tan(tangent_angle), -radius], tangent_angle),
        ctrl_p2 = [-ctrl_p.x, ctrl_p.y] + [centre_dist / 2, 0],
        ctrl_p3 = [-ctrl_p2.x, ctrl_p2.y],
        ctrl_p4 = [-ctrl_p1.x, ctrl_p1.y]
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

function _liquid_splitting_lower_half_curve(curve_pts, leng) =
    [
        for(i = 0; i < leng; i = i + 1)
        let(p = curve_pts[leng - 1 - i])
        if(p.x >= 0) p
    ]; 
    
function _liquid_splitting_half_liquid_splitting(radius, centre_dist, tangent_angle, t_step) =
    let(
        pie_curve_pts = _liquid_splitting_pie_curve(radius, centre_dist, tangent_angle),
        curve_pts = _liquid_splitting_bezier(radius, centre_dist, tangent_angle, t_step, pie_curve_pts[0]),
        lower_curve_pts = _liquid_splitting_lower_half_curve(curve_pts, len(curve_pts)),
        leng_half_curve_pts = len(lower_curve_pts),
        upper_curve_pts = [
            for(i = 0; i < leng_half_curve_pts; i = i + 1)
                let(pt = lower_curve_pts[leng_half_curve_pts - 1 - i])
                [pt.x, -pt.y]
        ]
    ) concat(
        lower_curve_pts,
        pie_curve_pts,        
        upper_curve_pts
    );
    
function _shape_liquid_splitting_impl(radius, centre_dist, tangent_angle, t_step) =
    let(
        half_liquid_splittings = _liquid_splitting_half_liquid_splitting(radius, centre_dist, tangent_angle, t_step),
        leng_half_liquid_splittings = len(half_liquid_splittings),
        left_half_liquid_splittings = [
            for(i = 0; i < leng_half_liquid_splittings; i = i + 1)
                let(pt = half_liquid_splittings[leng_half_liquid_splittings - 1 - i])
                [-pt.x, pt.y]
        ]    
    ) concat(half_liquid_splittings, left_half_liquid_splittings);