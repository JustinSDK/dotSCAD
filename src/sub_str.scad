/**
* sub_str.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-sub_str.html
*
**/ 

function _sub_str(t, begin, end) = 
    begin == end ? "" : str(t[begin], sub_str(t, begin + 1, end));
    
function sub_str(t, begin, end) = 
    end == undef ? _sub_str(t, begin, len(t)) : _sub_str(t, begin, end);
    