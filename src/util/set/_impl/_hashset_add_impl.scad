use <../../some.scad>;

function _hashset_add(set, elem, eq, hash) =
    let(
	    idx = hash(elem) % len(set),
		bucket = set[idx]
	)
	some(bucket, function(e) eq(e, elem)) ? set : _add(set, bucket, elem, idx);

function _add(set, bucket, elem, idx) = 
    let(leng = len(set))
	[for(i = 0; i < leng; i = i + 1) i == idx ? concat(bucket, [elem]) : set[i]];