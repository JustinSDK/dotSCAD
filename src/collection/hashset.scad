use <../util/sum.scad>;
use <../util/slice.scad>;
use <../util/some.scad>;

function strhash(value) = 
    let(
	    s = str(value),
		leng = len(s)
	)
	sum([
	    for(i = [0:leng - 1])
		ord(s[i]) * pow(31, leng - 1 - i)
	]);
	
df_hash = function(e) strhash(e);
df_eq = function(e1, e2) e1 == e2;
	
function hashset(elems, bucket_size = 16, hash = df_hash, eq = df_eq) =
    let(
	    elems_undef = is_undef(elems),
	    size = elems_undef ? bucket_size : len(elems),
	    buckets = [for(i = [0:bucket_size - 1]) []]
	)
	elems_undef ? buckets :
	_hashset(elems, len(elems), buckets, hash, eq);
	
function _hashset(elems, leng, buckets, hash, eq, i = 0) = 
    i == leng ? buckets :
	_hashset(elems, leng, hashset_add(buckets, elems[i], hash, eq), hash, eq, i + 1);

function hashset_has(set, elem, hash = df_hash, eq = df_eq) =
    some(set[hash(elem) % len(set)], function(e) eq(e, elem));
	
function hashset_add(set, elem, hash = df_hash, eq = df_eq) =
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
	
function hashset_del(set, elem, hash = df_hash, eq = df_eq) =
    let(
	    bidx = hash(elem) % len(set),
		bucket = set[bidx],
		leng = len(bucket)
	)
	leng == 0 ? set :
	let(i = _find(bucket, elem, eq, leng), _ = echo(i))
	i == -1 ? set : 
	concat(
	    slice(set, 0, bidx), 
		[concat(slice(bucket, 0, i), slice(bucket, i + 1))],
		slice(set, bidx + 1)
	);

function _find(lt, elem, eq, leng, i = 0) =
    i == leng ? -1 :
    eq(lt[i], elem) ? i : _find(lt, elem, eq, leng, i + 1);

function hashset_list(set) = [
    for(bucket = set) 
        for(elem = bucket)
            elem		
];