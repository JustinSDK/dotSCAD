use <_hashset_add_impl.scad>;

function _hashset(lt, leng, buckets, b_numbers, eq, hash, i = 0) = 
    i == leng ? buckets :
    let(n_buckets = _hashset_add(buckets, b_numbers, lt[i], eq, hash))
	_hashset(lt, leng, n_buckets, b_numbers, eq, hash, i + 1);