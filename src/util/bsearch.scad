/**
* bsearch.scad
*
* @copyright Justin Lin, 2020
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-bsearch.html
*
**/

use <_impl/_bsearch_impl.scad>

function bsearch(sorted, target) = 
    echo("bsearch is deprecated. use util/binary_search instead.")
    is_function(target) ? _bsearch_cmp(sorted, target, 0, len(sorted) - 1) :
                          _bsearch_vt(sorted, target, 0, len(sorted) - 1); // `sorted` is by zyx