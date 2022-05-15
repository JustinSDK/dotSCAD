/**
* ptf_circle.scad
*
* @copyright Justin Lin, 2020
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-ptf_circle.html
*
**/ 

function ptf_circle(size, point) =
    let(p = point - size / 2)
    p == [0, 0] ? p :
    [p.y, p.x] * (max(abs(p.x), abs(p.y)) / norm(p) * 1.41421356237);