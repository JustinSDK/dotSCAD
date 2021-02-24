/**
* fibonacci_lattice.scad
*
* @copyright Justin Lin, 2020
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-fibonacci_lattice.html
*
**/

function fibonacci_lattice(n, radius = 1, dir = "CT_CLK") =
    let(
        toDegrees = 180 / PI,
        phi = PI * (3 - sqrt(5)),
        clk = dir == "CT_CLK" ? 1 : -1
    )
    [
        for(i = [0:n - 1])
        let(
            z = 1 - (2* i + 1) / n,
            r = sqrt(1 - z * z),
            theta = phi * i * clk,
            x = cos(theta * toDegrees) * r,
            y = sin(theta * toDegrees) * r
        )
        [x, y, z] * radius
    ];