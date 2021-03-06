use <_hashmap_put_impl.scad>;

function _hashmap(kv_lt, leng, buckets, eq, hash, i = 0) = 
    i == leng ? buckets :
	_hashmap(kv_lt, leng, _hashmap_put(buckets, kv_lt[i][0], kv_lt[i][1], eq, hash), eq, hash, i + 1);