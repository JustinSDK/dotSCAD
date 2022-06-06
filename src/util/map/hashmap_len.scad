/**
* hashmap_len.scad
*
* @copyright Justin Lin, 2021
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-hashmap_len.html
*
**/

use <../sum.scad>

function hashmap_len(map) = sum([for(bucket = map) len(bucket)]);