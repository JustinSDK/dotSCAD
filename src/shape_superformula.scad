/**
* shape_superformula.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-shape_superformula.html
*
**/ 

use <_impl/_shape_superformula_impl.scad>

function shape_superformula(phi_step, m1, m2, n1, n2 = 1, n3 = 1, a = 1, b = 1) = 
   _shape_superformula_impl(phi_step, m1, m2, n1, n2, n3, a, b);