use <_hashmap_put_impl.scad>;

_find_eq_search = function(lt, target, eq)
    let(found = search([target], lt)[0])
    found == [] ? -1 : found;

_find_eq_some = function(lt, target, eq)
    let(
        leng = len(lt),
        indices = [for(i = 0; i < leng && !eq(lt[i], target); i = i + 1) undef],
        leng_indices = len(indices)
    )
    leng_indices == leng ? -1 : leng_indices;

function _hashmap(kv_lt, leng, buckets, b_numbers, eq, hash) =
    let(
        end = leng - 1,
        f_eq = is_undef(eq) ? _find_eq_search : _find_eq_some,
        n_buckets_lt = [
        for(i = 0, n_buckets = _hashmap_put_by(buckets, b_numbers, kv_lt[i][0], kv_lt[i][1], eq, hash, f_eq), is_continue = i < end;
            is_continue; 
            i = i + 1, is_continue = i < end, n_buckets = is_continue ? _hashmap_put_by(n_buckets, b_numbers, kv_lt[i][0], kv_lt[i][1], eq, hash, f_eq) : undef) 
            n_buckets
        ]
    )
    _hashmap_put_by(n_buckets_lt[end - 1], b_numbers, kv_lt[end][0], kv_lt[end][1], eq, hash, f_eq); 