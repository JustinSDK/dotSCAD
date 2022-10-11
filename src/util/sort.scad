/**
* sort.scad
*
* @copyright Justin Lin, 2019
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-sort.html
*
**/ 

use <_impl/_sort_impl.scad>

function sort(lt, by = "idx", idx = 0) = 
    echo("sort is deprecated. use util/sorted instead.")
    is_function(by) ? _sort_by_cmp(lt, by) :  // support function literal
    by == "vt" ? _vt_sort(lt) :      // for example, sort by zyx for a list of points
                 _sort_by(lt, by, idx);