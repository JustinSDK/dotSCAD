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
use <../some.scad>;

function hashset_has(set, elem, eq = function(e1, e2) e1 == e2, hash = function(e) _str_hash(e)) =
    some(set[hash(elem) % len(set)], function(e) eq(e, elem));