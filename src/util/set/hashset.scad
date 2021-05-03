/**
* hashset.scad
*
* @copyright Justin Lin, 2021
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-hashset.html
*
**/

use <../../__comm__/_str_hash.scad>;
use <_impl/_hashset_impl.scad>;
use <_impl/_hashset_add_impl.scad>;
	
function hashset(lt, eq = function(e1, e2) e1 == e2, hash = function(e) _str_hash(e), number_of_buckets) =
    let(
	    lt_undef = is_undef(lt),
		leng_lt = lt_undef ? -1 : len(lt),
		number_of_buckets_undef = is_undef(number_of_buckets),
		b_numbers = number_of_buckets_undef ? 
		               (lt_undef || leng_lt < 256 ? 16 : ceil(sqrt(leng_lt))) : number_of_buckets,
	    buckets = [for(i = [0:b_numbers - 1]) []]
	)
	lt_undef ? buckets : _hashset(lt, leng_lt, buckets, b_numbers, eq, hash);