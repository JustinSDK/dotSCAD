use <../../util/slice.scad>;
use <../../util/some.scad>;

function _hashset_add(set, elem, hash, eq) =
    let(
	    idx = hash(elem) % len(set),
		bucket = set[idx]
	)
	len(bucket) == 0 ? concat(slice(set, 0, idx), [[elem]], slice(set, idx + 1)) :
	some(bucket, function(e) eq(e, elem)) ? set :
	concat(
	    slice(set, 0, idx), 
		[concat(bucket, [elem])], 
		slice(set, idx + 1)
	);

function _hashset(elems, leng, buckets, hash, eq, i = 0) = 
    i == leng ? buckets :
	_hashset(elems, leng, _hashset_add(buckets, elems[i], hash, eq), hash, eq, i + 1);

function _find(lt, elem, eq, leng, i = 0) =
    i == leng ? -1 :
    eq(lt[i], elem) ? i : _find(lt, elem, eq, leng, i + 1);