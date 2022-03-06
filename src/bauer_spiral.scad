/**
* bauer_spiral.scad
*
* @copyright Justin Lin, 2019
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-bauer_spiral.html
*
**/

use <util/degrees.scad>;
use <util/radians.scad>;

function bauer_spiral(n, radius = 1, rt_dir = "CT_CLK") = 
    let(
        L = sqrt(n * PI),
        clk = rt_dir == "CT_CLK" ? 1 : -1
    )
    [
        for(k = 1; k <= n; k = k + 1)
        let(
            zk = 1 - (2 * k - 1) / n,
            phik = radians(acos(zk)),
            thetak = L * phik * clk,
            phikDegrees = degrees(phik),
            thetakDegrees = degrees(thetak),
            xk = sin(phikDegrees) * cos(thetakDegrees),
            yk = sin(phikDegrees) * sin(thetakDegrees)
        )
        [xk, yk, zk] * radius
    ];