/**
* split_str.scad
*
* Splits the given string around matches of the given delimiting character.
* It depends on the sub_str function so remember to include sub_str.scad.
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-split_str.html
*
**/ 
   
function _split_t_by(idxs, t, ts = [], i = -1) = 
    i == -1 ? _split_t_by(idxs, t, [sub_str(t, 0, idxs[0])], i + 1) : (
        i == len(idxs) - 1 ? concat(ts, sub_str(t, idxs[i] + 1)) : 
            _split_t_by(idxs, t, concat(ts, sub_str(t, idxs[i] + 1, idxs[i + 1])), i + 1)
    );        

function split_str(t, delimiter) = 
    len(search(delimiter, t)) == 0 ? 
        [t] : _split_t_by(search(delimiter, t, 0)[0], t);  