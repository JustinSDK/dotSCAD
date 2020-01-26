/**
* px_from.scad
*
* @copyright Justin Lin, 2019
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib2-px_from.html
*
**/ 

use <pixel/_impl/_px_from_impl.scad>;

function px_from(binaries, center = false, invert = false) = _px_from_impl(binaries, center, invert);