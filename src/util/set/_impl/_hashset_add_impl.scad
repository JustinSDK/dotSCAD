use <../../_impl/_find_eq.scad>;

function _hashset_add(buckets, b_numbers, elem, eq, hash) =
    let(
	    idx = hash(elem) % b_numbers,
		bucket = buckets[idx]
	)
	_find_eq(bucket, elem, eq) != -1 ? buckets : _add(buckets, b_numbers, bucket, elem, idx);

function _add(buckets, b_numbers, bucket, elem, idx) = 
	[for(i = 0; i < b_numbers; i = i + 1) i == idx ? [each bucket, elem] : buckets[i]];