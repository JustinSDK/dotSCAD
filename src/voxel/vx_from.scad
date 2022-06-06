/**
* vx_from.scad
*
* @copyright Justin Lin, 2020
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-vx_from.html
*
**/ 

use <_impl/_vx_from_impl.scad>

function vx_from(binaries, center = false, invert = false) = _vx_from_impl(binaries, center, invert);