/**
* hashmap.scad
*
* @copyright Justin Lin, 2021
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-hashmap.html
*
**/

use <_impl/_hashmap_impl.scad>
include <../../__comm__/_str_hash.scad>
	
function hashmap(kv_lt, eq = undef, hash = _str_hash, number_of_buckets) =
    let(
	    kv_lt_undef = is_undef(kv_lt),
		leng_kv_lt = kv_lt_undef ? -1 : len(kv_lt),
		b_numbers = is_undef(number_of_buckets) ? 
		               (kv_lt_undef || leng_kv_lt < 256 ? 16 : ceil(sqrt(leng_kv_lt))) : number_of_buckets,
	    buckets = [for(i = [0:b_numbers - 1]) []]
	)
	kv_lt_undef ? buckets : _hashmap(kv_lt, leng_kv_lt, buckets, b_numbers, eq, hash);