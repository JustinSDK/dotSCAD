/**
* bauer_spiral.scad
*
* @copyright Justin Lin, 2019
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib2x-bauer_spiral.html
*
**/

function bauer_spiral(n, radius = 1, rt_dir = "CT_CLK") = 
    let(
        L = sqrt(n * PI),
        toRadians = PI / 180,
        toDegrees = 180 / PI,
        clk = rt_dir == "CT_CLK" ? 1 : -1
    )
    [
        for(k = 1; k <= n; k = k + 1)
        let(
            zk = 1 - (2 * k - 1) / n,
            phik = acos(zk) * toRadians,
            thetak = L * phik * clk,
            phikDegrees = toDegrees * phik,
            thetakDegrees = toDegrees * thetak,
            xk = sin(phikDegrees) * cos(thetakDegrees),
            yk = sin(phikDegrees) * sin(thetakDegrees)
        )
        [xk, yk, zk] * radius
    ];