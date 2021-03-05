use <../__comm__/_str_hash.scad>;
use <../util/slice.scad>;

function _find(lt, elem, eq, leng, i = 0) =
    i == leng ? -1 :
    eq(lt[i], elem) ? i : _find(lt, elem, eq, leng, i + 1);

function hashset_del(set, elem, eq = function(e1, e2) e1 == e2, hash = function(e) _str_hash(e)) =
    let(
	    bidx = hash(elem) % len(set),
		bucket = set[bidx],
		leng = len(bucket)
	)
	leng == 0 ? set :
	let(i = _find(bucket, elem, eq, leng))
	i == -1 ? set : 
	concat(
	    slice(set, 0, bidx), 
		[concat(slice(bucket, 0, i), slice(bucket, i + 1))],
		slice(set, bidx + 1)
	);