/**
* hashmap_entries.scad
*
* @copyright Justin Lin, 2021
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-hashmap_entries.html
*
**/

function hashmap_entries(map) = [for(bucket = map) each bucket];