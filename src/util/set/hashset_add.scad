/**
* hashset_add.scad
*
* @copyright Justin Lin, 2021
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-hashset_add.html
*
**/

use <_impl/_hashset_add_impl.scad>

include <../../__comm__/_str_hash.scad>

function hashset_add(set, elem, eq = undef, hash = _str_hash) =
    _hashset_add(set, len(set), elem, eq, hash);