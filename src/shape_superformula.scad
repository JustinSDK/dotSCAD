/**
* shape_superformula.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-shape_superformula.html
*
**/ 

include <__private__/__ra_to_xy.scad>;
include <__private__/__to_degree.scad>;

function _superformula_r(angle, m1, m2, n1, n2 = 1, n3 = 1, a = 1, b = 1) = 
    pow(
        pow(abs(cos(m1 * angle / 4) / a), n2) + 
        pow(abs(sin(m2 * angle / 4) / b), n3),
        - 1 / n1    
    );

function shape_superformula(phi_step, m1, m2, n1, n2 = 1, n3 = 1, a = 1, b = 1) = 
   [
        for(phi = [0:phi_step:6.28318]) 
            let(
                angle = __to_degree(phi),
                r = _superformula_r(angle, m1, m2, n1, n2, n3, a, b)
                
            )
            __ra_to_xy(r, angle)
   ];