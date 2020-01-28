/**
* sub_str.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib2x-sub_str.html
*
**/ 

use <util/_impl/_sub_str_impl.scad>;

function sub_str(t, begin, end) = _sub_str_impl(t, begin, end);