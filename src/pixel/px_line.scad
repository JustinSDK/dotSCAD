/**
* px_line.scad
*
* @copyright Justin Lin, 2019
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib2-px_line.html
*
**/ 

use <pixel/_impl/_px_line_impl.scad>;

function px_line(p1, p2) = _px_line_impl(p1, p2);