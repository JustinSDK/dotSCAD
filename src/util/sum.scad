/**
* sum.scad
*
* @copyright Justin Lin, 2020
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-sum.html
*
**/ 

function sum(lt) = 
    let(end = len(lt) - 1)
    end == 0 ? lt[0] :
    let(cum_total = [for(i = 0, s = lt[0]; i < end; i = i + 1, s = s + lt[i]) s])
    cum_total[len(cum_total) - 1] + lt[end];