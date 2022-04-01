/**
* find_index.scad
*
* @copyright Justin Lin, 2021
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-find_index.html
*
**/ 

function find_index(lt, test) = 
    let(
        leng = len(lt),
        indices = [for(i = 0; i < leng && !test(lt[i]); i = i + 1) undef],
        leng_indices = len(indices)
    )
    leng_indices == leng ? -1 : leng_indices;