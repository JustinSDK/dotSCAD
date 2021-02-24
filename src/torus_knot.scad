/**
* torus_knot.scad
*
* @copyright Justin Lin, 2019
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-torus_knot.html
*
**/

function torus_knot(p, q, phi_step) = 
    let(tau = PI * 2)
    [
        for(phi = 0; phi < tau; phi = phi + phi_step)
        let(
            degree = phi * 180 / PI,
            r = cos(q * degree) + 2,
            x = r * cos(p * degree),
            y = r * sin(p * degree),
            z = -sin(q * degree)
        )
        [x, y, z]
    ];