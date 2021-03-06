use <../__comm__/_str_hash.scad>;
use <../util/slice.scad>;
use <../util/find_index.scad>;

function hashmap_del(map, key, eq = function(e1, e2) e1 == e2, hash = function(e) _str_hash(e)) =
    let(
	    bidx = hash(key) % len(map),
		bucket = map[bidx],
		leng = len(bucket)
	)
	leng == 0 ? map :
	let(i = find_index(bucket, function(e) eq(e[0], key)))
	i == -1 ? map : 
	concat(
	    slice(map, 0, bidx), 
		[concat(slice(bucket, 0, i), slice(bucket, i + 1))],
		slice(map, bidx + 1)
	);