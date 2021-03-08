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
	    bidx = hash(elem) % len(set),
		bucket = set[bidx],
		leng = len(bucket)
	)
	leng == 0 ? set :
	let(i = find_index(bucket, function(e) eq(e, elem)))
	i == -1 ? set : 
	concat(
	    slice(set, 0, bidx), 
		[concat(slice(bucket, 0, i), slice(bucket, i + 1))],
		slice(set, bidx + 1)
	);