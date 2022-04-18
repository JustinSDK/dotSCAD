/**
* zip.scad
*
* @copyright Justin Lin, 2020
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-zip.html
*
**/ 

function zip(lts, combine) = 
    let(end_lts = len(lts) - 1)
    is_undef(combine) ? 
        [
            for(i = [0:len(lts[0]) - 1])
            [for(j = [0:end_lts]) lts[j][i]]
        ] :
        [
            for(i = [0:len(lts[0]) - 1])
            combine([for(j = [0:end_lts]) lts[j][i]])
        ];