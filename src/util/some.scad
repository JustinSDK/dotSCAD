/**
* some.scad
*
* @copyright Justin Lin, 2021
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-some.html
*
**/ 

function some(lt, test) = 
    let(leng = len(lt)) 
    len([for(i = 0; i < leng && !test(lt[i]); i = i + 1) undef]) < leng;