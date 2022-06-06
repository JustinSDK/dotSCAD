use <../../_impl/_find_eq.scad>

function _hashmap_put(buckets, b_numbers, key, value, eq, hash) =
    let(
	    b_idx = hash(key) % b_numbers,
		bucket = buckets[b_idx]
	)
	bucket == [] ? _put(buckets, b_numbers, bucket, key, value, b_idx) :
	let(k_idx = _find_eq(bucket, key, eq))
	k_idx != -1 ? _replace(buckets, b_numbers, bucket, key, value, b_idx, k_idx) : 
	              _put(buckets, b_numbers, bucket, key, value, b_idx);
 
function _hashmap_put_by(buckets, b_numbers, key, value, eq, hash, f_eq) =
    let(
	    b_idx = hash(key) % b_numbers,
		bucket = buckets[b_idx]
	)
	bucket == [] ? _put(buckets, b_numbers, bucket, key, value, b_idx) :
	let(k_idx = f_eq(bucket, key, eq))
	k_idx != -1 ? _replace(buckets, b_numbers, bucket, key, value, b_idx, k_idx) : 
	              _put(buckets, b_numbers, bucket, key, value, b_idx);

function _replace(buckets, b_numbers, bucket, key, value, b_idx, k_idx) = 
    let(leng_bucket = len(bucket))
	[
		for(bi = 0; bi < b_numbers; bi = bi + 1) 
		if(bi == b_idx) 
		    [for(ki = 0; ki < leng_bucket; ki = ki + 1) ki == k_idx ? [key, value] : bucket[ki]] 
		else 
		    buckets[bi]
	];

function _put(buckets, b_numbers, bucket, key, value, b_idx) = 
    [for(i = 0; i < b_numbers; i = i + 1) i == b_idx ? [each bucket, [key, value]] : buckets[i]];