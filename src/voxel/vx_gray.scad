/**
* vx_gray.scad
*
* @copyright Justin Lin, 2020
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-vx_gray.html
*
**/ 

use <_impl/_vx_gray_impl.scad>

function vx_gray(levels, center = false, invert = false, normalize = false) = 
    _vx_gray_impl(levels, center, invert, normalize);