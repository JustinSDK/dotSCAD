/**
* split_str.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-split_str.html
*
**/ 
   
use <_impl/_split_str_impl.scad>

function split_str(t, delimiter) = _split_str_impl(t, delimiter);          