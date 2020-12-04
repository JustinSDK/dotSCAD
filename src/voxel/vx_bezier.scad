use <__comm__/__to2d.scad>;
use <__comm__/__to3d.scad>;
use <_impl/_vx_bezier_impl.scad>;

function vx_bezier(p1, p2, p3, p4) = 
    let(
        is2d = len(p1) == 2,
        pts = is2d ? _vx_bezier2(__to3d(p1), __to3d(p2), __to3d(p3), __to3d(p4), []) :
                     _vx_bezier3(p1, p2, p3, p4, [])
    )
    is2d ? [for(p = pts) __to2d(p)] : pts;