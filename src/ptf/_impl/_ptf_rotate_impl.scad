use <../../__comm__/__to2d.scad>;
use <../../__comm__/__to3d.scad>;
use <../../__comm__/__to_ang_vect.scad>;

function _q_rotate_p_3d(p, a, v) = 
    let(
        half_a = a / 2,
        axis = v / norm(v),
        s = sin(half_a),
        x = s * axis.x,
        y = s * axis.y,
        z = s * axis.z,
        w = cos(half_a),
        
        x2 = x + x,
        y2 = y + y,
        z2 = z + z,

        xx = x * x2,
        yx = y * x2,
        yy = y * y2,
        zx = z * x2,
        zy = z * y2,
        zz = z * z2,
        wx = w * x2,
        wy = w * y2,
        wz = w * z2        
    )
    [
        [1 - yy - zz, yx - wz, zx + wy] * p,
        [yx + wz, 1 - xx - zz, zy - wx] * p,
        [zx - wy, zy + wx, 1 - xx - yy] * p
    ];

function _rotx(pt, a) = 
    a == 0 ? pt :
    let(cosa = cos(a), sina = sin(a))
    [
        pt.x, 
        pt.y * cosa - pt[2] * sina,
        pt.y * sina + pt[2] * cosa
    ];

function _roty(pt, a) = 
    a == 0 ? pt :
    let(cosa = cos(a), sina = sin(a))
    [
        pt.x * cosa + pt.z * sina, 
        pt.y,
        -pt.x * sina + pt.z * cosa, 
    ];

function _rotz(pt, a) = 
    a == 0 ? pt :
    let(cosa = cos(a), sina = sin(a))
    [
        pt.x * cosa - pt.y * sina,
        pt.x * sina + pt.y * cosa,
        pt.z
    ];

function _rotate_p_3d(point, a) =
    _rotz(_roty(_rotx(point, a.x), a.y), a.z);

function _rotate_p(p, a) =
    let(angle = __to_ang_vect(a))
    len(p) == 3 ? 
        _rotate_p_3d(p, angle) :
        __to2d(
            _rotate_p_3d(__to3d(p), angle)
        );


function _q_rotate_p(p, a, v) =
    len(p) == 3 ? 
        _q_rotate_p_3d(p, a, v) :
        __to2d(
            _q_rotate_p_3d(__to3d(p), a, v)
        );

function _rotate_p_impl(point, a, v) =
    is_undef(v) ? _rotate_p(point, a) : _q_rotate_p(point, a, v);
