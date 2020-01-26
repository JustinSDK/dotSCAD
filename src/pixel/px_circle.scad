/**
* px_circle.scad
*
* @copyright Justin Lin, 2019
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib2-px_circle.html
*
**/ 

use <pixel/_impl/_px_circle_impl.scad>;

function px_circle(radius, filled = false) = _px_circle_impl(radius, filled);