/**
* reverse.scad
*
* @copyright Justin Lin, 2019
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-rand.html
*
**/ 

function rand(min_value = 0, max_value = 1, seed_value) = 
    is_undef(seed_value) ? rands(min_value, max_value , 1)[0] : rands(min_value, max_value , 1, seed_value)[0];