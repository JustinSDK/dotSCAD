/**
* px_line.scad
*
* @copyright Justin Lin, 2019
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib2-px_line.html
*
**/ 

include <__comm__/__to3d.scad>;
include <__comm__/__to2d.scad>;

function _px_line_zsgn(a) = a == 0 ? a : a / abs(a);
    
// x-dominant
function _px_line_xdominant_y(y, yd, sy) = yd >= 0 ? y + sy : y;
function _px_line_xdominant_yd(yd, ax, ay) = (yd >= 0 ? yd - ax : yd) + ay;
function _px_line_xdominant_z(z, zd, sz) = zd >= 0 ? z + sz : z;
function _px_line_xdominant_zd(zd, ax, az) = (zd >= 0 ? zd - ax : zd) + az;

function _px_line_xdominant(start, end, a, s) = 
    let(
        x = start[0],
        y = start[1],
        z = start[2],
        ax = a[0],
        ay = a[1],
        az = a[2],
        sx = s[0],
        sy = s[1],
        sz = s[2],        
        shrx = floor(ax / 2),
        yd = ay - shrx,
        zd = az - shrx,
        endx = end[0]
    )
    concat(
        [start], 
        _px_line_xdominant_sub(
            x + sx, 
            _px_line_xdominant_y(y, yd, sy), 
            _px_line_xdominant_z(z, zd, sz), 
            endx, 
            a, 
            s, 
            _px_line_xdominant_yd(yd, ax, ay), 
            _px_line_xdominant_zd(zd, ax, az)
        )
    );

function _px_line_xdominant_sub(x, y, z, endx, a, s, yd, zd) = 
    let(
        ax = a[0],
        ay = a[1],
        az = a[2],
        sx = s[0],
        sy = s[1],
        sz = s[2]
    )
    x == endx ? [] : 
        concat([[x, y, z]], 
            _px_line_xdominant_sub(
                x + sx, 
                _px_line_xdominant_y(y, yd, sy), 
                _px_line_xdominant_z(z, zd, sz), 
                endx, 
                a, 
                s, 
                _px_line_xdominant_yd(yd, ax, ay), 
                _px_line_xdominant_zd(zd, ax, az)
            )
        );
        
// y-dominant
function _px_line_ydominant_x(x, xd, sx) = xd >= 0 ? x + sx : x;
function _px_line_ydominant_xd(xd, ax, ay) = (xd >= 0 ? xd - ay : xd) + ax;
function _px_line_ydominant_z(z, zd, sz) = zd >= 0 ? z + sz : z;
function _px_line_ydominant_zd(zd, ay, az) = (zd >= 0 ? zd - ay : zd) + az;
        
function _px_line_ydominant(start, end, a, s) = 
    let(
        x = start[0],
        y = start[1],
        z = start[2],
        ax = a[0],
        ay = a[1],
        az = a[2],
        sx = s[0],
        sy = s[1],
        sz = s[2],        
        shry = floor(ay / 2),
        xd = ax - shry,
        zd = az - shry,
        endy = end[1]
    )
    concat(
        [start], 
        _px_line_ydominant_sub(
            _px_line_ydominant_x(x, xd, sx), 
            y + sy,
            _px_line_ydominant_z(z, zd, sz), 
            endy, 
            a, 
            s, 
            _px_line_ydominant_xd(xd, ax, ay), 
            _px_line_ydominant_zd(zd, ay, az)
        )
    );

function _px_line_ydominant_sub(x, y, z, endy, a, s, xd, zd) = 
    let(
        ax = a[0],
        ay = a[1],
        az = a[2],
        sx = s[0],
        sy = s[1],
        sz = s[2]
    )
    y == endy ? [] : 
        concat([[x, y, z]], 
            _px_line_ydominant_sub(
                _px_line_ydominant_x(x, xd, sx), 
                y + sy,
                _px_line_ydominant_z(z, zd, sz), 
                endy, 
                a, 
                s, 
                _px_line_ydominant_xd(xd, ax, ay), 
                _px_line_ydominant_zd(zd, ay, az)
            )
        );

// z-dominant
function _px_line_zdominant_x(x, xd, sx) = xd >= 0 ? x + sx : x;
function _px_line_zdominant_xd(xd, ax, az) = (xd >= 0 ? xd - az : xd) + ax;

function _px_line_zdominant_y(y, yd, sy) = yd >= 0 ? y + sy : y;
function _px_line_zdominant_yd(yd, ay, az) = (yd >= 0 ? yd - az : yd) + ay;
        
function _px_line_zdominant(start, end, a, s) = 
    let(
        x = start[0],
        y = start[1],
        z = start[2],
        ax = a[0],
        ay = a[1],
        az = a[2],
        sx = s[0],
        sy = s[1],
        sz = s[2],        
        shrz = floor(az / 2),
        xd = ax - shrz,
        yd = ay - shrz,
        endz = end[2]
    )
    concat(
        [start], 
        _px_line_zdominant_sub(
            _px_line_zdominant_x(x, xd, sx), 
            _px_line_zdominant_y(y, yd, sy), 
            z + sz,
            endz, 
            a, 
            s, 
            _px_line_zdominant_xd(xd, ax, az), 
            _px_line_zdominant_yd(yd, ay, az)
        )
    );

function _px_line_zdominant_sub(x, y, z, endz, a, s, xd, yd) = 
    let(
        ax = a[0],
        ay = a[1],
        az = a[2],
        sx = s[0],
        sy = s[1],
        sz = s[2]
    )
    z == endz ? [] : 
        concat([[x, y, z]], 
            _px_line_zdominant_sub(
                _px_line_zdominant_x(x, xd, sx), 
                _px_line_zdominant_y(y, yd, sy), 
                z + sz,
                endz, 
                a, 
                s, 
                _px_line_zdominant_xd(xd, ax, az), 
                _px_line_zdominant_yd(yd, ay, az)
            )
        );
        
function px_line(p1, p2) = 
    let(
        is_2d = len(p1) == 2,
        start_pt = is_2d ? __to3d(p1) : p1,
        end_pt = is_2d ? __to3d(p2) : p2,
        dt = end_pt - start_pt,
        ax = floor(abs(dt[0]) * 2),
        ay = floor(abs(dt[1]) * 2),
        az = floor(abs(dt[2]) * 2),
        sx = _px_line_zsgn(dt[0]),
        sy = _px_line_zsgn(dt[1]),
        sz = _px_line_zsgn(dt[2]),
        points = ax >= max(ay, az) ? _px_line_xdominant(start_pt, end_pt, [ax, ay, az], [sx, sy, sz]) : (
            ay >= max(ax, az) ? _px_line_ydominant(start_pt, end_pt, [ax, ay, az], [sx, sy, sz]) :
                _px_line_zdominant(start_pt, end_pt, [ax, ay, az], [sx, sy, sz])
        )
    )   
    is_2d ? [for(pt = points) __to2d(pt)] : points;