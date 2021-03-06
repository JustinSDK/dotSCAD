use <_hashmap_add_impl.scad>;

function _hashmap(kv_lt, leng, buckets, eq, hash, i = 0) = 
    i == leng ? buckets :
	_hashmap(kv_lt, leng, _hashmap_add(buckets, kv_lt[i][0], kv_lt[i][1], eq, hash), eq, hash, i + 1);