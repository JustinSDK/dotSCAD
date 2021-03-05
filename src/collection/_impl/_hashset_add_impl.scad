use <../../util/slice.scad>;
use <../../util/some.scad>;

function _hashset_add(set, elem, eq, hash) =
    let(
	    idx = hash(elem) % len(set),
		bucket = set[idx]
	)
	len(bucket) == 0 ? concat(slice(set, 0, idx), [[elem]], slice(set, idx + 1)) :
	some(bucket, function(e) eq(e, elem)) ? set :
	concat(
	    slice(set, 0, idx), 
		[concat(bucket, [elem])], 
		slice(set, idx + 1)
	);