/**
* footprints3.scad
*
* @copyright Justin Lin, 2020
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-footprints3.html
*
**/ 

use <turtle3d.scad>

function footprints3(cmds, start = [0, 0, 0]) = 
    let(leng = len(cmds))
    [start, each [
        for(i = 0, t = turtle3d(cmds[i][0], turtle3d("create", start, [[1, 0, 0], [0, 1, 0], [0, 0, 1]]), cmds[i][1]); 
            i < leng;
            i = i + 1,
            t = turtle3d(cmds[i][0], t, cmds[i][1]))
        if(cmds[i][0] == "forward") turtle3d("pt", t)
    ]];
