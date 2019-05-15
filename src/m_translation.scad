/**
* m_translation.scad
*
* @copyright Justin Lin, 2019
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-m_translation.html
*
**/

include <__private__/__is_float.scad>;

function _to_3_elems_translation_vect(v) =
     let(leng = len(v))
     leng == 3 ? v : (
         leng == 2 ? [v[0], v[1], 0] : [v[0], 0, 0]
     );

function _to_translation_vect(v) = __is_float(v) ? [v, 0, 0] : _to_3_elems_translation_vect(v);

function m_translation(v) = 
    let(vt = _to_translation_vect(v))
    [
        [1, 0, 0, vt[0]],
        [0, 1, 0, vt[1]],
        [0, 0, 1, vt[2]],
        [0, 0, 0, 1]
    ];