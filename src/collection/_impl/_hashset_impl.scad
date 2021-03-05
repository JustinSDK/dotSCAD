use <_hashset_add_impl.scad>;

function _hashset(elems, leng, buckets, eq, hash, i = 0) = 
    i == leng ? buckets :
	_hashset(elems, leng, _hashset_add(buckets, elems[i], eq, hash), eq, hash, i + 1);