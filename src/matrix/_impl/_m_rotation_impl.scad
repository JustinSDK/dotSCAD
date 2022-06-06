use <../../__comm__/__to_ang_vect.scad>

FINAL_ROW = [0, 0, 0, 1];
function __m_rotation_q_rotation(a, v) = 
    let(
        uv = v / norm(v),
        s = sin(a / 2) * uv,
        w = sin(a) * uv,

        xx = 2 * s.x ^ 2,
        yy = 2 * s.y ^ 2,
        zz = 2 * s.z ^ 2,

        xy = 2 * s.x * s.y,
        xz = 2 * s.x * s.z,
        yz = 2 * s.y * s.z
    )
    [
        [1 - yy - zz, xy - w.z, xz + w.y, 0],
        [xy + w.z, 1 - xx - zz, yz - w.x, 0],
        [xz - w.y, yz + w.x, 1 - xx - yy, 0],
        FINAL_ROW
    ];

function __m_rotation_xRotation(a) = 
    let(c = cos(a), s = sin(a))
    [
        [1, 0, 0, 0],
        [0, c, -s, 0],
        [0, s, c, 0],
        FINAL_ROW
    ];

function __m_rotation_yRotation(a) = 
    let(c = cos(a), s = sin(a))
    [
        [c, 0, s, 0],
        [0, 1, 0, 0],
        [-s, 0, c, 0],
        FINAL_ROW
    ];    

function __m_rotation_zRotation(a) = 
    let(c = cos(a), s = sin(a))
    [
        [c, -s, 0, 0],
        [s, c, 0, 0],
        [0, 0, 1, 0],
        FINAL_ROW
    ];    

function __m_rotation_xyz_rotation(a) =
    let(ang = __to_ang_vect(a))
    __m_rotation_zRotation(ang[2]) * __m_rotation_yRotation(ang[1]) * __m_rotation_xRotation(ang[0]);

function _m_rotation_impl(a, v) = 
    (a == 0 || a == [0, 0, 0] || a == [0] || a == [0, 0]) ? [
        [1, 0, 0, 0],
        [0, 1, 0, 0],
        [0, 0, 1, 0],
        FINAL_ROW
    ] : (is_undef(v) ? __m_rotation_xyz_rotation(a) : __m_rotation_q_rotation(a, v));