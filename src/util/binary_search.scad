/**
* binary_search.scad
*
* @copyright Justin Lin, 2022
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-binary_search.html
*
**/

use <_impl/_binary_search_impl.scad>

function binary_search(sorted, target, lo = 0, hi = undef) = 
    _binary_search_impl(
        sorted, 
        is_function(target) ? target : function(elem) elem == target ? 0 : elem > target ? 1 : -1, 
        lo, 
        is_undef(hi) ? len(sorted) - 1 : hi
    );