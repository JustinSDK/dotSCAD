/**
* midpt_smooth.scad
*
* @copyright Justin Lin, 2019
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-midpt_smooth.html
*
**/

function _midpt_smooth_sub(points, iend, closed = false) = 
    concat(
        [
            for(i = 0; i < iend; i = i + 1) 
                (points[i] + points[i + 1]) / 2
        ],
        closed ? [(points[iend] + points[0]) / 2] : []
    );

function midpt_smooth(points, n, closed = false) =
    let(
        smoothed = _midpt_smooth_sub(points, len(points) - 1, closed)
    )
    n == 1 ? smoothed : midpt_smooth(smoothed, n - 1, closed);