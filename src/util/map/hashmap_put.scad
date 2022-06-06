/**
* hashmap_put.scad
*
* @copyright Justin Lin, 2021
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-hashmap_put.html
*
**/

use <_impl/_hashmap_put_impl.scad>

include <../../__comm__/_str_hash.scad>

function hashmap_put(map, key, value, eq = undef, hash = _str_hash) =
    _hashmap_put(map, len(map), key, value, eq, hash);