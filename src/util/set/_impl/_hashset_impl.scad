use <_hashset_add_impl.scad>;

function _hashset(lt, leng, buckets, b_numbers, eq, hash) = 
    let(
        end = leng - 1,
        n_buckets_lt = [
        for(i = 0, n_buckets = _hashset_add(buckets, b_numbers, lt[i], eq, hash);
            i < end; 
            i = i + 1, n_buckets = _hashset_add(n_buckets, b_numbers, lt[i], eq, hash)) 
            n_buckets
        ]
    )
    _hashset_add(n_buckets_lt[len(n_buckets_lt) - 1], b_numbers, lt[end], eq, hash); 


