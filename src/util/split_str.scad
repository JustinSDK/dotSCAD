/**
* split_str.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib2-split_str.html
*
**/ 
   
function _split_t_by(idxs, t) =
    let(leng = len(idxs))
    concat(
        [sub_str(t, 0, idxs[0])],
        [
            for(i = 0; i < leng; i = i + 1)
                sub_str(t, idxs[i] + 1, idxs[i + 1])
        ]
    );
             
function split_str(t, delimiter) = 
    len(search(delimiter, t)) == 0 ? 
        [t] : _split_t_by(search(delimiter, t, 0)[0], t);  