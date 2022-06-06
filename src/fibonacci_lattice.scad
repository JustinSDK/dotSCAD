/**
* fibonacci_lattice.scad
*
* @copyright Justin Lin, 2020
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-fibonacci_lattice.html
*
**/

use <util/degrees.scad>

function fibonacci_lattice(n, radius = 1, dir = "CT_CLK") =
    let(
        phi = PI * (3 - sqrt(5)),
        clk = dir == "CT_CLK" ? 1 : -1
    )
    [
        for(i = [0:n - 1])
        let(
            z = 1 - (2 * i + 1) / n,        // cos_phi
            sin_phi = sqrt(1 - z ^ 2),
            theta = clk * i * degrees(phi)
        )
        [cos(theta) * sin_phi, sin(theta) * sin_phi, z] * radius
    ];