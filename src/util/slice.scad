/**
* slice.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib2-slice.html
*
**/ 

function slice(lt, begin, end) = 
    let(ed = is_undef(end) ? len(lt) : end)
    [for(i = begin; i < ed; i = i + 1) lt[i]];
    