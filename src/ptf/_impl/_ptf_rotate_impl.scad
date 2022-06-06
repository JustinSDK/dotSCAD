use <../../__comm__/__to2d.scad>
use <../../__comm__/__to3d.scad>
use <../../__comm__/__to_ang_vect.scad>
use <../../util/unit_vector.scad>

function _q_rotate_p_3d(p, a, v) = 
    let(
        uv = unit_vector(v),
        s = sin(a / 2) * uv,
        w = sin(a) * uv,

        xx = 2 * s.x ^ 2,
        yy = 2 * s.y ^ 2,
        zz = 2 * s.z ^ 2,

        xy = 2 * s.x * s.y,
        xz = 2 * s.x * s.z,
        yz = 2 * s.y * s.z
    )
    p * [
        [1 - yy - zz, xy - w.z, xz + w.y],
        [xy + w.z, 1 - xx - zz, yz - w.x],
        [xz - w.y, yz + w.x, 1 - xx - yy]
    ];

function _rotx(pt, a) = 
    a == 0 ? pt :
    let(cosa = cos(a), sina = sin(a))
    [
        pt.x, 
        pt.y * cosa - pt.z * sina,
        pt.y * sina + pt.z * cosa
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
