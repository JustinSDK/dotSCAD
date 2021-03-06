use <_hashset_add_impl.scad>;

function _hashset(lt, leng, buckets, eq, hash, i = 0) = 
    i == leng ? buckets :
	_hashset(lt, leng, _hashset_add(buckets, lt[i], eq, hash), eq, hash, i + 1);