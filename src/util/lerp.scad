/**
* lerp.scad
*
* @copyright Justin Lin, 2020
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-lerp.html
*
**/ 

function lerp(v1, v2, amt) = v1 + (v2 - v1) * amt;