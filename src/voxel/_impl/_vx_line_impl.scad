
use <../../__comm__/__to3d.scad>
use <../../__comm__/__to2d.scad>
    
// x-dominant
function _xdominant_y(y, yd, sy) = yd >= 0 ? y + sy : y;
function _xdominant_yd(yd, ax, ay) = (yd >= 0 ? yd - ax : yd) + ay;
function _xdominant_z(z, zd, sz) = zd >= 0 ? z + sz : z;
function _xdominant_zd(zd, ax, az) = (zd >= 0 ? zd - ax : zd) + az;

function _xdominant(start, end, a, s) = 
    let(     
        shrx = floor(a.x / 2),
        yd = a.y - shrx,
        zd = a.z - shrx
    )
    [
        start,
        each _xdominant_sub(
            start.x + s.x, 
            _xdominant_y(start.y, yd, s.y), 
            _xdominant_z(start.z, zd, s.z), 
            end.x, 
            a, 
            s, 
            _xdominant_yd(yd, a.x, a.y), 
            _xdominant_zd(zd, a.x, a.z)
        )
    ];

function _xdominant_sub(x, y, z, endx, a, s, yd, zd) = 
    x == endx ? [] : [
        [x, y, z], 
        each _xdominant_sub(
            x + s.x, 
            _xdominant_y(y, yd, s.y), 
            _xdominant_z(z, zd, s.z), 
            endx, 
            a, 
            s, 
            _xdominant_yd(yd, a.x, a.y), 
            _xdominant_zd(zd, a.x, a.z)
        )
    ];
        
// y-dominant
function _ydominant_x(x, xd, sx) = xd >= 0 ? x + sx : x;
function _ydominant_xd(xd, ax, ay) = (xd >= 0 ? xd - ay : xd) + ax;
function _ydominant_z(z, zd, sz) = zd >= 0 ? z + sz : z;
function _ydominant_zd(zd, ay, az) = (zd >= 0 ? zd - ay : zd) + az;
        
function _ydominant(start, end, a, s) = 
    let(   
        shry = floor(a.y / 2),
        xd = a.x - shry,
        zd = a.z - shry
    )
    [
        start,
        each _ydominant_sub(
            _ydominant_x(start.x, xd, s.x), 
            start.y + s.y,
            _ydominant_z(start.z, zd, s.z), 
            end.y, 
            a, 
            s, 
            _ydominant_xd(xd, a.x, a.y), 
            _ydominant_zd(zd, a.y, a.z)
        )
    ];

function _ydominant_sub(x, y, z, endy, a, s, xd, zd) = 
    y == endy ? [] : [
        [x, y, z],
        each _ydominant_sub(
            _ydominant_x(x, xd, s.x), 
            y + s.y,
            _ydominant_z(z, zd, s.z), 
            endy, 
            a, 
            s, 
            _ydominant_xd(xd, a.x, a.y), 
            _ydominant_zd(zd, a.y, a.z)
        )
    ];

// z-dominant
function _zdominant_x(x, xd, sx) = xd >= 0 ? x + sx : x;
function _zdominant_xd(xd, ax, az) = (xd >= 0 ? xd - az : xd) + ax;

function _zdominant_y(y, yd, sy) = yd >= 0 ? y + sy : y;
function _zdominant_yd(yd, ay, az) = (yd >= 0 ? yd - az : yd) + ay;
        
function _zdominant(start, end, a, s) = 
    let(   
        shrz = floor(a.z / 2),
        xd = a.x - shrz,
        yd = a.y - shrz
    )
    [
        start, 
        each _zdominant_sub(
            _zdominant_x(start.x, xd, s.x), 
            _zdominant_y(start.y, yd, s.y), 
            start.z + s.z,
            end.z, 
            a, 
            s, 
            _zdominant_xd(xd, a.x, a.z), 
            _zdominant_yd(yd, a.y, a.z)
        )
    ];

function _zdominant_sub(x, y, z, endz, a, s, xd, yd) = 
    z == endz ? [] : [
        [x, y, z],
        each _zdominant_sub(
            _zdominant_x(x, xd, s.x), 
            _zdominant_y(y, yd, s.y), 
            z + s.z,
            endz, 
            a, 
            s, 
            _zdominant_xd(xd, a.x, a.z), 
            _zdominant_yd(yd, a.y, a.z)
        )
    ];

function _vx_line_impl(p1, p2) = 
    let(
        is_2d = len(p1) == 2,
        start_pt = is_2d ? __to3d(p1) : p1,
        end_pt = is_2d ? __to3d(p2) : p2,
        dt = end_pt - start_pt,
        a = [for(c = dt) floor(abs(c) * 2)],
        s = [for(c = dt) sign(c)],
        points = a.x >= max(a.y, a.z) ? _xdominant(start_pt, end_pt, a, s) : 
                 a.y >= max(a.x, a.z) ? _ydominant(start_pt, end_pt, a, s) :
                                        _zdominant(start_pt, end_pt, a, s)
    )   
    is_2d ? [for(pt = points) __to2d(pt)] : points;