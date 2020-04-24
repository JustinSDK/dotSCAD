/**
* px_gray.scad
*
* @copyright Justin Lin, 2019
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib2x-px_gray.html
*
**/ 

use <_impl/_px_gray_impl.scad>;

function px_gray(levels, center = false, invert = false, normalize = false) = 
    _px_gray_impl(levels, center, invert, normalize);