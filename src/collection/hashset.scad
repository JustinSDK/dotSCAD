use <__comm__/_str_hash.scad>;
use <_impl/_hashset_impl.scad>;
use <../util/slice.scad>;
use <../util/some.scad>;

// public functions: hashset, hashset_has, hashset_add, hashset_del, hashset_list

/*
use <collection/hashset.scad>;

s = hashset([1, 2, 3, 4, 5, 2, 3, 5]);
echo(hashset_list(s));
s2 = hashset_add(s, 9);
echo(hashset_list(s2));

echo(hashset_has(s2, 13));

echo(hashset_list(hashset_del(s2, 2)));
*/


df_hash = function(e) _str_hash(e);
df_eq = function(e1, e2) e1 == e2;
	
function hashset(lt, hash = df_hash, eq = df_eq, bucket_size = 16) =
    let(
	    lt_undef = is_undef(lt),
	    size = lt_undef ? bucket_size : len(lt),
	    buckets = [for(i = [0:bucket_size - 1]) []]
	)
	lt_undef ? buckets :
	_hashset(lt, len(lt), buckets, hash, eq);

function hashset_has(set, elem, hash = df_hash, eq = df_eq) =
    some(set[hash(elem) % len(set)], function(e) eq(e, elem));
	
function hashset_add(set, elem, hash = df_hash, eq = df_eq) =
    _hashset_add(set, elem, hash, eq);
	
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

function hashset_list(set) = [
    for(bucket = set) 
        for(elem = bucket)
            elem		
];