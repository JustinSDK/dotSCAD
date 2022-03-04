/**
* dedup.scad
*
* @copyright Justin Lin, 2020
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-dedup.html
*
**/ 

use <../__comm__/_str_hash.scad>;
use <_impl/_dedup_impl.scad>;
use <sort.scad>;

function dedup(lt, eq = function(e1, e2) e1 == e2, hash = function(e) _str_hash(e), number_of_buckets) =
    let(leng_lt = len(lt))
    leng_lt < 2 ? lt :
	let(
		b_numbers = is_undef(number_of_buckets) ? ceil(sqrt(leng_lt)) : number_of_buckets,
	    buckets = [for(i = [0:b_numbers - 1]) []],
		deduped = _dedup(lt, leng_lt, buckets, eq, hash, b_numbers),
		i_elem_lt = [for(bucket = deduped) each bucket],
		sorted = sort(i_elem_lt, by = function(e1, e2) e1[0] - e2[0])
	)
	[for(i_elem = sorted) i_elem[1]];
