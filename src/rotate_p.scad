/**
* rotate_p.scad
*
* Rotates a point 'a' degrees around an arbitrary axis. 
* The rotation is applied in the following order: x, y, z. 
* 
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-rotate_p.html
*
**/ 

module arc(radius, angles, width, width_mode = "LINE_CROSS") {
    w_offset = width_mode == "LINE_CROSS" ? [width / 2, -width / 2] : (
        width_mode == "LINE_INWARD" ? [0, -width] : [width, 0]
    );
    
    difference() {
        circular_sector(radius + w_offset[0], angles);
        circular_sector(radius + w_offset[1], angles);
    }
}

function _rotx(pt, a) = 
    let(cosa = cos(a), sina = sin(a))
    [
        pt[0], 
        pt[1] * cosa - pt[2] * sina,
        pt[1] * sina + pt[2] * cosa
    ];

function _roty(pt, a) = 
    let(cosa = cos(a), sina = sin(a))
    [
        pt[0] * cosa + pt[2] * sina, 
        pt[1],
        -pt[0] * sina + pt[2] * cosa, 
    ];

function _rotz(pt, a) = 
    let(cosa = cos(a), sina = sin(a))
    [
        pt[0] * cosa - pt[1] * sina,
        pt[0] * sina + pt[1] * cosa,
        pt[2]
    ];

function rotate_p(point, a) =
    _rotz(_roty(_rotx(point, a[0]), a[1]), a[2]);