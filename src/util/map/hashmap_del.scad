/**
* hashmap_del.scad
*
* @copyright Justin Lin, 2021
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-hashmap_del.html
*
**/

use <../_impl/_find_eq.scad>
include <../../__comm__/_str_hash.scad>

function hashmap_del(map, key, eq = undef, hash = _str_hash) =
    let(
	    bidx = hash(key) % len(map),
		bucket = map[bidx],
		leng_bucket = len(bucket),
		leng_map = len(map)
	)
	leng_bucket == 0 ? map :
	let(i = _find_eq(bucket, key, eq))
	i == -1 ? map : 
	[
	    for(j = 0; j < leng_map; j = j + 1) j == bidx ? 
	        [for(k = 0; k < leng_bucket; k = k + 1) if(k != i) bucket[k]] :
			map[j]
	];