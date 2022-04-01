/**
* hashset_add.scad
*
* @copyright Justin Lin, 2021
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-hashset_add.html
*
**/

use <../../__comm__/_str_hash.scad>;
use <_impl/_hashset_add_impl.scad>;

function hashset_add(set, elem, eq = undef, hash = function(e) _str_hash(e)) =
    _hashset_add(set, len(set), elem, eq, hash);