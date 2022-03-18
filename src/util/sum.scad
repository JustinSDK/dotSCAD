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
    let(
        cum_total = [
            for(i = 0, s = lt[0], is_continue = i < end; 
                is_continue; 
                i = i + 1, is_continue = i < end, s = is_continue ? s + lt[i] : undef) s]
    )
    cum_total[end - 1] + lt[end];