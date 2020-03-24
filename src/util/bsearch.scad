/**
* bsearch.scad
*
* @copyright Justin Lin, 2020
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib2x-bsearch.html
*
**/

use <util/_impl/_bsearch_impl.scad>;

function bsearch(sorted, elem, by = "idx", idx = 0) = 
    by == "vt" ? _bsearch_vt(sorted, elem, 0, len(sorted) - 1) : // for example, `sorted` is by zyx
                 _bsearch_by(sorted, elem, by, idx);