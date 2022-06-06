
/**
* footprints2.scad
*
* @copyright Justin Lin, 2020
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-footprints2.html
*
**/ 

use <turtle2d.scad>

function footprints2(cmds, start = [0, 0]) = 
    let(leng = len(cmds))
    [start, each [
        for(i = 0, t = turtle2d(cmds[i][0], turtle2d("create", start.x, start.y, 0), cmds[i][1]); 
            i < leng;
            i = i + 1,
            t = turtle2d(cmds[i][0], t, cmds[i][1]))
        if(cmds[i][0] == "forward") turtle2d("pt", t)
    ]];