/**
* vx_contour.scad
*
* @copyright Justin Lin, 2020
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib2x-vx_contour.html
*
**/ 

use <_impl/_vx_contour_impl.scad>;
use <util/sort.scad>;

function vx_contour(points, sorted = false) = 
    let(
        // always start from the left-bottom pt
        sortedXY = sorted ? points : sort(points, by = "vt"),
        fst = sortedXY[0] + [-1, -1]
    )
    _vx_contour_travel(sortedXY, fst, fst);