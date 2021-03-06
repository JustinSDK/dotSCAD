use <../../slice.scad>;
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
		n_bucket = concat(
			slice(bucket, 0, k_idx),
			[[key, value]],
			slice(bucket, k_idx + 1)
		)
	)
	concat(
		slice(map, 0, b_idx), 
		[n_bucket], 
		slice(map, b_idx + 1)
	);

function _put(map, bucket, key, value, b_idx) = concat(
	slice(map, 0, b_idx), 
	[concat(bucket, [[key, value]])], 
	slice(map, b_idx + 1)
);