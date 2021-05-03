use <../../some.scad>;
use <../../find_index.scad>;

function _hashmap_put(buckets, b_numbers, key, value, eq, hash) =
    let(
	    b_idx = hash(key) % b_numbers,
		bucket = buckets[b_idx],
		k_idx = find_index(bucket, function(kv) eq(kv[0], key))
	)
	k_idx != -1 ? _replace(buckets, b_numbers, bucket, key, value, b_idx, k_idx) : 
	              _put(buckets, b_numbers, bucket, key, value, b_idx);

function _replace(buckets, b_numbers, bucket, key, value, b_idx, k_idx) = 
    let(
	    leng_bucket = len(bucket),
		n_bucket = [for(i = 0; i < leng_bucket; i = i + 1) i == k_idx ? [key, value] : bucket[i]]
	)
	[for(i = 0; i < b_numbers; i = i + 1) i == b_idx ? n_bucket : buckets[i]];

function _put(buckets, b_numbers, bucket, key, value, b_idx) = 
    [for(i = 0; i < b_numbers; i = i + 1) i == b_idx ? concat(bucket, [[key, value]]) : buckets[i]];