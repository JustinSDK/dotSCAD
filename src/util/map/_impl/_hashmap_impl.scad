use <_hashmap_put_impl.scad>;

function _hashmap(kv_lt, leng, buckets, b_numbers, eq, hash) =
    let(
        end = leng - 1,
        n_buckets_lt = [
        for(i = 0, n_buckets = _hashmap_put(buckets, b_numbers, kv_lt[i][0], kv_lt[i][1], eq, hash), is_continue = i < end;
            is_continue; 
            i = i + 1, is_continue = i < end, n_buckets = is_continue ? _hashmap_put(n_buckets, b_numbers, kv_lt[i][0], kv_lt[i][1], eq, hash) : undef) 
            n_buckets
        ]
    )
    _hashmap_put(n_buckets_lt[end - 1], b_numbers, kv_lt[end][0], kv_lt[end][1], eq, hash); 