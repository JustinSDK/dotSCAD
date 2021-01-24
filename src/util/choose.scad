/**
* choose.scad
*
* @copyright Justin Lin, 2021
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib2x-choose.html
*
**/

function choose(choices, seed) =
    let(c = is_undef(seed) ? rands(0, len(choices) - 1, 1) : rands(0, len(choices) - 1, 1, seed)) 
    choices[round(c[0])];