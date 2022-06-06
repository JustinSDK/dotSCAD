/**
* hashset.scad
*
* @copyright Justin Lin, 2021
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-hashset.html
*
**/

use <_impl/_hashset_impl.scad>
use <_impl/_hashset_add_impl.scad>

include <../../__comm__/_str_hash.scad>
	
function hashset(lt, eq = undef, hash = _str_hash, number_of_buckets) =
    let(
	    lt_undef = is_undef(lt),
		leng_lt = lt_undef ? -1 : len(lt),
		b_numbers = is_undef(number_of_buckets) ? 
		               (lt_undef || leng_lt < 256 ? 16 : ceil(sqrt(leng_lt))) : number_of_buckets,
	    buckets = [for(i = [0:b_numbers - 1]) []]
	)
	lt_undef ? buckets : _hashset(lt, leng_lt, buckets, b_numbers, eq, hash);