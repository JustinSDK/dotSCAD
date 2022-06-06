use <_hashset_add_impl.scad>

include <../../_impl/_find_eq_search_some.scad>

function _hashset(lt, leng, buckets, b_numbers, eq, hash) = 
    let(
        end = leng - 1,
        f_eq = is_undef(eq) ? _find_eq_search : _find_eq_some,
        n_buckets_lt = [
        for(i = 0, n_buckets = _hashset_add_by(buckets, b_numbers, lt[i], eq, hash, f_eq), is_continue = i < end;
            is_continue; 
            i = i + 1, is_continue = i < end, n_buckets = is_continue ? _hashset_add_by(n_buckets, b_numbers, lt[i], eq, hash, f_eq) : undef) 
            n_buckets
        ]
    )
    _hashset_add_by(n_buckets_lt[end - 1], b_numbers, lt[end], eq, hash, f_eq); 


