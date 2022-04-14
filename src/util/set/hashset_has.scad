/**
* hashset_has.scad
*
* @copyright Justin Lin, 2021
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-hashset_has.html
*
**/

use <../../__comm__/_str_hash.scad>;
use <../_impl/_find_eq.scad>;

function hashset_has(set, elem, eq = undef, hash = function(e) _str_hash(e)) =
    let(bucket = set[hash(elem) % len(set)])
    bucket != [] && _find_eq(bucket, elem, eq) != -1;