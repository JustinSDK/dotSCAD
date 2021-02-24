/**
* footprints2.scad
*
* @copyright Justin Lin, 2020
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-footprints2.html
*
**/ 

use <_impl/_footprints2.scad>;
use <turtle2d.scad>;

function footprints2(cmds, start = [0, 0]) = 
    let(
        t = turtle2d("create", start[0], start[1], 0),
        leng = len(cmds)
    )
    concat([turtle2d("pt", t)], _footprints2(cmds, t, leng));