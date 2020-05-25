/**
* footprints3.scad
*
* @copyright Justin Lin, 2020
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib2x-footprints3.html
*
**/ 

use <_impl/_footprints3.scad>;
use <turtle3d.scad>;

function footprints3(cmds, start = [0, 0, 0]) = 
    let(
        t = turtle3d("create", start, [[1, 0, 0], [0, 1, 0], [0, 0, 1]]),
        leng = len(cmds)
    )
    concat([turtle3d("pt", t)], _footprints3(cmds, t, leng));