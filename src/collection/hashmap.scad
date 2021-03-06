use <../__comm__/_str_hash.scad>;
use <_impl/_hashmap_impl.scad>;
use <_impl/_hashmap_add_impl.scad>;
	
function hashmap(kv_lt, eq = function(e1, e2) e1 == e2, hash = function(e) _str_hash(e), bucket_numbers) =
    let(
	    kv_lt_undef = is_undef(kv_lt),
		leng_kv_lt = kv_lt_undef ? -1 : len(kv_lt),
		bucket_numbers_undef = is_undef(bucket_numbers),
		b_numbers = bucket_numbers_undef ? 
		               (kv_lt_undef || leng_kv_lt < 256 ? 16 : ceil(sqrt(leng_kv_lt))) : bucket_numbers,
	    buckets = [for(i = [0:b_numbers - 1]) []]
	)
	kv_lt_undef ? buckets : _hashmap(kv_lt, leng_kv_lt, buckets, eq, hash);