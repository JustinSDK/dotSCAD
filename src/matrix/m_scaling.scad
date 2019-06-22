/**
* m_scaling.scad
*
* @copyright Justin Lin, 2019
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-m_scaling.html
*
**/

function _to_3_elems_scaling_vect(s) =
     let(leng = len(s))
     leng == 3 ? s : (
         leng == 2 ? [s[0], s[1], 1] : [s[0], 1, 1]
     );

function _to_scaling_vect(s) = is_num(s) ? [s, s, s] : _to_3_elems_scaling_vect(s);

function m_scaling(s) = 
    let(v = _to_scaling_vect(s))
    [
        [v[0], 0, 0, 0],
        [0, v[1], 0, 0],
        [0, 0, v[2], 0],
        [0, 0, 0, 1]
    ];