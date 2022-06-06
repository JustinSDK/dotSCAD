/**
* dedup.scad
*
* @copyright Justin Lin, 2020
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-dedup.html
*
**/ 

use <_impl/_dedup_impl.scad>

include <../__comm__/_str_hash.scad>
		
function dedup(lt, eq = undef, hash = _str_hash, number_of_buckets) =
    let(leng_lt = len(lt))
    leng_lt < 2 ? lt :
	let(
		b_numbers = is_undef(number_of_buckets) ? ceil(sqrt(leng_lt)) : number_of_buckets,
	    buckets = [for(i = [0:b_numbers - 1]) []]
	)
	_sort([for(bucket = _dedup(lt, leng_lt, buckets, eq, hash, b_numbers)) each bucket]);
