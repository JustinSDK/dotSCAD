/**
* hashset_has.scad
*
* @copyright Justin Lin, 2021
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-hashset_has.html
*
**/

use <../_impl/_find_eq.scad>

include <../../__comm__/_str_hash.scad>

function hashset_has(set, elem, eq = undef, hash = _str_hash) =
    let(bucket = set[hash(elem) % len(set)])
    bucket != [] && _find_eq(bucket, elem, eq) != -1;