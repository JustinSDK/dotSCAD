/**
* sub_str.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-sub_str.html
*
**/ 

function sub_str(t, begin, end) = 
    let(
        ed = is_undef(end) ? len(t) : end,
        cum = [for(i = begin, s = t[i]; i < ed; i = i + 1, s = str(s, t[i])) s]
    )
    cum[len(cum) - 1];