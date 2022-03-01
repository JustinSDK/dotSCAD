
use <../../__comm__/__to3d.scad>;
use <../../__comm__/__to2d.scad>;

function _vx_line_zsgn(a) = a == 0 ? a : a / abs(a);
    
// x-dominant
function _vx_line_xdominant_y(y, yd, sy) = yd >= 0 ? y + sy : y;
function _vx_line_xdominant_yd(yd, ax, ay) = (yd >= 0 ? yd - ax : yd) + ay;
function _vx_line_xdominant_z(z, zd, sz) = zd >= 0 ? z + sz : z;
function _vx_line_xdominant_zd(zd, ax, az) = (zd >= 0 ? zd - ax : zd) + az;

function _vx_line_xdominant(start, end, a, s) = 
    let(     
        shrx = floor(a.x / 2),
        yd = a.y - shrx,
        zd = a.z - shrx
    )
    [
        start,
        each _vx_line_xdominant_sub(
            start.x + s.x, 
            _vx_line_xdominant_y(start.y, yd, s.y), 
            _vx_line_xdominant_z(start.z, zd, s.z), 
            end.x, 
            a, 
            s, 
            _vx_line_xdominant_yd(yd, a.x, a.y), 
            _vx_line_xdominant_zd(zd, a.x, a.z)
        )
    ];

function _vx_line_xdominant_sub(x, y, z, endx, a, s, yd, zd) = 
    x == endx ? [] : [
        [x, y, z], 
        each _vx_line_xdominant_sub(
            x + s.x, 
            _vx_line_xdominant_y(y, yd, s.y), 
            _vx_line_xdominant_z(z, zd, s.z), 
            endx, 
            a, 
            s, 
            _vx_line_xdominant_yd(yd, a.x, a.y), 
            _vx_line_xdominant_zd(zd, a.x, a.z)
        )
    ];
        
// y-dominant
function _vx_line_ydominant_x(x, xd, sx) = xd >= 0 ? x + sx : x;
function _vx_line_ydominant_xd(xd, ax, ay) = (xd >= 0 ? xd - ay : xd) + ax;
function _vx_line_ydominant_z(z, zd, sz) = zd >= 0 ? z + sz : z;
function _vx_line_ydominant_zd(zd, ay, az) = (zd >= 0 ? zd - ay : zd) + az;
        
function _vx_line_ydominant(start, end, a, s) = 
    let(   
        shry = floor(a.y / 2),
        xd = a.x - shry,
        zd = a.z - shry
    )
    [
        start,
        each _vx_line_ydominant_sub(
            _vx_line_ydominant_x(start.x, xd, s.x), 
            start.y + s.y,
            _vx_line_ydominant_z(start.z, zd, s.z), 
            end.y, 
            a, 
            s, 
            _vx_line_ydominant_xd(xd, a.x, a.y), 
            _vx_line_ydominant_zd(zd, a.y, a.z)
        )
    ];

function _vx_line_ydominant_sub(x, y, z, endy, a, s, xd, zd) = 
    y == endy ? [] : [
        [x, y, z],
        each _vx_line_ydominant_sub(
            _vx_line_ydominant_x(x, xd, s.x), 
            y + s.y,
            _vx_line_ydominant_z(z, zd, s.z), 
            endy, 
            a, 
            s, 
            _vx_line_ydominant_xd(xd, a.x, a.y), 
            _vx_line_ydominant_zd(zd, a.y, a.z)
        )
    ];

// z-dominant
function _vx_line_zdominant_x(x, xd, sx) = xd >= 0 ? x + sx : x;
function _vx_line_zdominant_xd(xd, ax, az) = (xd >= 0 ? xd - az : xd) + ax;

function _vx_line_zdominant_y(y, yd, sy) = yd >= 0 ? y + sy : y;
function _vx_line_zdominant_yd(yd, ay, az) = (yd >= 0 ? yd - az : yd) + ay;
        
function _vx_line_zdominant(start, end, a, s) = 
    let(   
        shrz = floor(a.z / 2),
        xd = a.x - shrz,
        yd = a.y - shrz
    )
    [
        start, 
        each _vx_line_zdominant_sub(
            _vx_line_zdominant_x(start.x, xd, s.x), 
            _vx_line_zdominant_y(start.y, yd, s.y), 
            start.z + s.z,
            end.z, 
            a, 
            s, 
            _vx_line_zdominant_xd(xd, a.x, a.z), 
            _vx_line_zdominant_yd(yd, a.y, a.z)
        )
    ];

function _vx_line_zdominant_sub(x, y, z, endz, a, s, xd, yd) = 
    z == endz ? [] : [
        [x, y, z],
        each _vx_line_zdominant_sub(
            _vx_line_zdominant_x(x, xd, s.x), 
            _vx_line_zdominant_y(y, yd, s.y), 
            z + s.z,
            endz, 
            a, 
            s, 
            _vx_line_zdominant_xd(xd, a.x, a.z), 
            _vx_line_zdominant_yd(yd, a.y, a.z)
        )
    ];

function _vx_line_impl(p1, p2) = 
    let(
        is_2d = len(p1) == 2,
        start_pt = is_2d ? __to3d(p1) : p1,
        end_pt = is_2d ? __to3d(p2) : p2,
        dt = end_pt - start_pt,
        ax = floor(abs(dt[0]) * 2),
        ay = floor(abs(dt[1]) * 2),
        az = floor(abs(dt[2]) * 2),
        sx = _vx_line_zsgn(dt[0]),
        sy = _vx_line_zsgn(dt[1]),
        sz = _vx_line_zsgn(dt[2]),
        points = ax >= max(ay, az) ? _vx_line_xdominant(start_pt, end_pt, [ax, ay, az], [sx, sy, sz]) : (
            ay >= max(ax, az) ? _vx_line_ydominant(start_pt, end_pt, [ax, ay, az], [sx, sy, sz]) :
                _vx_line_zdominant(start_pt, end_pt, [ax, ay, az], [sx, sy, sz])
        )
    )   
    is_2d ? [for(pt = points) __to2d(pt)] : points;