/**
* hashmap_keys.scad
*
* @copyright Justin Lin, 2021
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-hashmap_keys.html
*
**/

function hashmap_keys(map) = [for(bucket = map, kv = bucket) kv[0]];