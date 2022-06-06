/**
* hashset_del.scad
*
* @copyright Justin Lin, 2021
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-hashset_del.html
*
**/

use <../_impl/_find_eq.scad>

include <../../__comm__/_str_hash.scad>

function hashset_del(set, elem, eq = undef, hash = _str_hash) =
    let(
	    leng_set = len(set),
	    bidx = hash(elem) % leng_set,
		bucket = set[bidx],
		leng_bucket = len(bucket)
	)
	leng_bucket == 0 ? set :
	let(i = _find_eq(bucket, elem, eq))
	i == -1 ? set : 
	[
	    for(j = 0; j < leng_set; j = j + 1) j == bidx ? 
		    [for(k = 0; k < leng_bucket; k = k + 1) if(k != i) bucket[k]] : 
			set[j]
	];
