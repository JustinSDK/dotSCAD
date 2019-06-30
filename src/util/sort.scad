/**
* sort.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib2-sort.html
*
**/ 

function _sort(lt, i) = 
    let(leng = len(lt))
    leng <= 1 ? lt : 
        let(
            pivot = lt[0],
            before = [for(j = 1; j < leng; j = j + 1) if(lt[j][i] < pivot[i]) lt[j]],
            after =  [for(j = 1; j < leng; j = j + 1) if(lt[j][i] >= pivot[i]) lt[j]]
        )
        concat(_sort(before, i), [pivot], _sort(after, i));

function sort(lt, by = "idx", idx = 0) =
    let(
        dict = [["x", 0], ["y", 1], ["z", 0], ["idx", idx]],
        i = dict[search(by, dict)[0]][1]
    )
    _sort(lt, i);