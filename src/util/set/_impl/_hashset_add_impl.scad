use <../../some.scad>;

function _hashset_add(buckets, b_numbers, elem, eq, hash) =
    let(
	    idx = hash(elem) % b_numbers,
		bucket = buckets[idx]
	)
	some(bucket, function(e) eq(e, elem)) ? buckets : _add(buckets, b_numbers, bucket, elem, idx);

function _add(buckets, b_numbers, bucket, elem, idx) = 
	[for(i = 0; i < b_numbers; i = i + 1) i == idx ? concat(bucket, [elem]) : buckets[i]];