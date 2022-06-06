/**
* hashset_len.scad
*
* @copyright Justin Lin, 2021
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-hashset_len.html
*
**/

use <../sum.scad>

function hashset_len(set) = sum([for(bucket = set) len(bucket)]);