/**
* torus_knot.scad
*
* @copyright Justin Lin, 2019
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-torus_knot.html
*
**/

use <util/degrees.scad>

function torus_knot(p, q, phi_step) = 
    [
        for(phi = 0; phi < 6.283185307179586; phi = phi + phi_step)
        let(
            deg_qp = degrees(q * phi),
            deg_pp = degrees(p * phi),
            r = cos(deg_qp) + 2
        )
        [r * cos(deg_pp), r * sin(deg_pp), -sin(deg_qp)]
    ];