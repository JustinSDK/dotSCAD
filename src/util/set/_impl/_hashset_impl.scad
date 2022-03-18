use <_hashset_add_impl.scad>;

function _hashset(lt, leng, buckets, b_numbers, eq, hash) = 
    let(
        end = leng - 1,
        n_buckets_lt = [
        for(i = 0, n_buckets = _hashset_add(buckets, b_numbers, lt[i], eq, hash), is_continue = i < end;
            is_continue; 
            i = i + 1, is_continue = i < end, n_buckets = is_continue ? _hashset_add(n_buckets, b_numbers, lt[i], eq, hash) : undef) 
            n_buckets
        ]
    )
    _hashset_add(n_buckets_lt[end - 1], b_numbers, lt[end], eq, hash); 


