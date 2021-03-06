
use <../slice.scad>;
use <../some.scad>;

function _dedup(elems, leng, buckets, eq, hash, bucket_numbers, i = 0) = 
    i == leng ? buckets :
	_dedup(elems, leng, _dedup_add(buckets, [i, elems[i]], eq, hash, bucket_numbers), eq, hash, bucket_numbers, i + 1);

function _dedup_add(buckets, i_elem, eq, hash, bucket_numbers) =
    let(
		i =  i_elem[0],
		elem = i_elem[1],
	    b_idx = hash(elem) % bucket_numbers,
		bucket = buckets[b_idx]
	)
	some(bucket, function(i_e) eq(i_e[1], elem)) ? buckets : _add(buckets, bucket, i_elem, b_idx);

function _add(buckets, bucket, i_elem, b_idx) = concat(
	slice(buckets, 0, b_idx), 
	[concat(bucket, [i_elem])], 
	slice(buckets, b_idx + 1)
);