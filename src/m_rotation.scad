/**
* m_rotation.scad
*
* @copyright Justin Lin, 2019
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-m_rotation.html
*
**/

include <__private__/__is_float.scad>;

function _q_rotation(a, v) = 
    let(
        half_a = a / 2,
        axis = v / norm(v),
        s = sin(half_a),
        x = s * axis[0],
        y = s * axis[1],
        z = s * axis[2],
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
        [1 - yy - zz, yx - wz, zx + wy, 0],
        [yx + wz, 1 - xx - zz, zy - wx, 0],
        [zx - wy, zy + wx, 1 - xx - yy, 0],
        [0, 0, 0, 1]
    ];

function _m_xRotation(a) = 
    let(c = cos(a), s = sin(a))
    [
        [1, 0, 0, 0],
        [0, c, -s, 0],
        [0, s, c, 0],
        [0, 0, 0, 1]
    ];

function _m_yRotation(a) = 
    let(c = cos(a), s = sin(a))
    [
        [c, 0, s, 0],
        [0, 1, 0, 0],
        [-s, 0, c, 0],
        [0, 0, 0, 1]
    ];    

function _m_zRotation(a) = 
    let(c = cos(a), s = sin(a))
    [
        [c, -s, 0, 0],
        [s, c, 0, 0],
        [0, 0, 1, 0],
        [0, 0, 0, 1]
    ];    

function _to_3_elems_vect(a) =
     let(leng = len(a))
     leng == 3 ? a : (
         leng == 2 ? [a[0], a[1], 0] :  [a[0], 0, 0]
     );

function _to_ang_vect(a) = __is_float(a) ? [0, 0, a] :  _to_3_elems_vect(a);

function _xyz_rotation(a) =
    let(ang = _to_ang_vect(a))
    _m_zRotation(ang[2]) * _m_yRotation(ang[1]) * _m_xRotation(ang[0]);

function m_rotation(a, v) = 
    (a == 0 || a == [0, 0, 0] || a == [0] || a == [0, 0]) ? [
        [1, 0, 0, 0],
        [0, 1, 0, 0],
        [0, 0, 1, 0],
        [0, 0, 0, 1]
    ] : (v == undef ? _xyz_rotation(a) : _q_rotation(a, v));