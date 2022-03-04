/**
* hashset_elems.scad
*
* @copyright Justin Lin, 2021
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-hashset_elems.html
*
**/

function hashset_elems(set) = [for(bucket = set) each bucket];