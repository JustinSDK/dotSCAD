/**
* lerp.scad
*
* @copyright Justin Lin, 2020
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-lerp.html
*
**/ 

function lerp(v1, v2, amt) = 
    let(v = v2 - v1, leng = len(v1))
    [for(i = 0; i < leng; i = i + 1) v1[i] + v[i] * amt];