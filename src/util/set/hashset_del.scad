/**
* hashset_del.scad
*
* @copyright Justin Lin, 2021
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-hashset_del.html
*
**/

use <../../__comm__/_str_hash.scad>;
use <../slice.scad>;
use <../find_index.scad>;

function hashset_del(set, elem, eq = function(e1, e2) e1 == e2, hash = function(e) _str_hash(e)) =
    let(
	    leng_set = len(set),
	    bidx = hash(elem) % leng_set,
		bucket = set[bidx],
		leng_bucket = len(bucket)
	)
	leng_bucket == 0 ? set :
	let(i = find_index(bucket, function(e) eq(e, elem)))
	i == -1 ? set : 
	[
	    for(j = 0; j < leng_set; j = j + 1) j == bidx ? 
		    [for(k = 0; k < leng_bucket; k = k + 1) if(k != i) bucket[k]] : 
			set[j]
	];
