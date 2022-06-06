use <../__comm__/__to3d.scad>
use <../util/reverse.scad>

function __polytransversals(transversals) =
    let(
        leng_trs = len(transversals),
        leng_tr = len(transversals[0]),
        lefts = [for(i = 1; i < leng_trs - 1; i = i + 1) transversals[leng_trs - i][0]],
        rights = [for(i = 1; i < leng_trs - 1; i = i + 1) transversals[i][leng_tr - 1]]
    ) concat(
        transversals[0], 
        rights, 
        reverse(transversals[leng_trs - 1]), 
        lefts
    );

function _az(p1, p2) = let(v = p2 - p1) -90 + atan2(v.y, v.x);

function _rz_matrix(p1, p2) = 
    let(v = p2 - p1, a = -90 + atan2(v.y, v.x), c = cos(a), s = sin(a)) 
    [
        [c, -s],
        [s,  c],
    ];  

function _first_stroke(stroke_pts, path_pts) =
    let(
        p1 = path_pts[0],
        p2 = path_pts[1],
        m = _rz_matrix(p1, p2)
    )
    [for(p = stroke_pts) m * p + p1];    

function _stroke(stroke_pts, p1, p2, scale_step, i) =
    let(
        leng = norm(__to3d(p2) - __to3d(p1)),
        m = _rz_matrix(p1, p2),
        s = 1 + scale_step * i,
        off_p = [0, leng]
    )
    [for(p = stroke_pts * s) m * (p + off_p) + p1];
    
function _inner(stroke_pts, path_pts, leng_path_pts, scale_step) =
    [
        for(i = 1; i < leng_path_pts; i = i + 1)
        _stroke(
            stroke_pts, 
            path_pts[i - 1], 
            path_pts[i ], 
            scale_step, 
            i 
        )
    ];

function _shape_path_extend_impl(stroke_pts, path_pts, scale, closed) =
    let(
        leng_path_pts = len(path_pts),
        scale_step = (scale - 1) / (leng_path_pts - 1),
        strokes = _inner(stroke_pts, path_pts, leng_path_pts, scale_step)        
    )
    closed && path_pts[0] == path_pts[leng_path_pts - 1] ? 
        __polytransversals([each strokes, strokes[0]]) : 
        __polytransversals([_first_stroke(stroke_pts, path_pts), each strokes]);
        
