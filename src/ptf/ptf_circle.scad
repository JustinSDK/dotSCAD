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
    let(
        p_offset = -size / 2,
        p = point + p_offset,
        leng = norm(p)
    )
    leng == 0 ? [0, 0] :
    let(
        n = max(abs(p.x), abs(p.y)),
        r = n * 1.414
    )
    [p.y, p.x] * (r / leng);