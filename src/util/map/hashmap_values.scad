/**
* hashmap_values.scad
*
* @copyright Justin Lin, 2021
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-hashmap_values.html
*
**/

function hashmap_values(map) = [for(bucket = map, kv = bucket) kv[1]];