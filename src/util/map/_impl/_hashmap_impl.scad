use <_hashmap_put_impl.scad>;

function _hashmap(kv_lt, leng, buckets, b_numbers, eq, hash, i = 0) = 
    i == leng ? buckets :
    let(n_buckets = _hashmap_put(buckets, b_numbers, kv_lt[i][0], kv_lt[i][1], eq, hash))
	_hashmap(kv_lt, leng, n_buckets, b_numbers, eq, hash, i + 1);