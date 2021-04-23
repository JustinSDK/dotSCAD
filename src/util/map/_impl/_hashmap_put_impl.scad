use <../../some.scad>;
use <../../find_index.scad>;

function _hashmap_put(map, key, value, eq, hash) =
    let(
	    b_idx = hash(key) % len(map),
		bucket = map[b_idx],
		k_idx = find_index(bucket, function(kv) eq(kv[0], key))
	)
	k_idx != -1 ? _replace(map, bucket, key, value, b_idx, k_idx) : 
	              _put(map, bucket, key, value, b_idx);

function _replace(map, bucket, key, value, b_idx, k_idx) = 
    let(
	    leng_bucket = len(bucket),
		n_bucket = [for(i = 0; i < leng_bucket; i = i + 1) i == k_idx ? [key, value] : bucket[i]],
		leng_map = len(map)
	)
	[for(i = 0; i < leng_map; i = i + 1) i == b_idx ? n_bucket : map[i]];

function _put(map, bucket, key, value, b_idx) = 
    let(leng_map = len(map))
    [for(i = 0; i < leng_map; i = i + 1) i == b_idx ? concat(bucket, [[key, value]]) : map[i]];