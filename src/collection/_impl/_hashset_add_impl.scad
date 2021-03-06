use <../../util/slice.scad>;
use <../../util/some.scad>;

function _hashset_add(set, elem, eq, hash) =
    let(
	    idx = hash(elem) % len(set),
		bucket = set[idx]
	)
	some(bucket, function(e) eq(e, elem)) ? set : _add(set, bucket, elem, idx);

function _add(set, bucket, elem, idx) = concat(
	slice(set, 0, idx), 
	[concat(bucket, [elem])], 
	slice(set, idx + 1)
);
