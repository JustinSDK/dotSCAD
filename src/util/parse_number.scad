/**
* parse_number.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-parse_number.html
*
**/ 

use <_impl/_parse_number_impl.scad>
         
function parse_number(t) = _parse_number_impl(t);