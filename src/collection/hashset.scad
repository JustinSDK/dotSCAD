use <../__comm__/_str_hash.scad>;
use <_impl/_hashset_impl.scad>;
use <_impl/_hashset_add_impl.scad>;
	
function hashset(lt, eq = function(e1, e2) e1 == e2, hash = function(e) _str_hash(e), bucket_numbers) =
    let(
		leng_lt = len(lt),
	    lt_undef = is_undef(lt),
		bucket_numbers_undef = is_undef(bucket_numbers),
		b_numbers = bucket_numbers_undef ? 
		               (lt_undef ? 16 : ceil(sqrt(leng_lt))) : bucket_numbers,
	    buckets = [for(i = [0:b_numbers - 1]) []]
	)
	lt_undef ? buckets : _hashset(lt, leng_lt, buckets, eq, hash);