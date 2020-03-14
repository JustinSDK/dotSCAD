/**
* sort.scad
*
* @copyright Justin Lin, 2019
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib2x-sort.html
*
**/ 

use <util/_impl/_sort_impl.scad>;

function sort(lt, by = "idx", idx = 0) = 
    by == "vt" ? _vt_sort(lt) :      // for example, sort by zyx for a list of points
                 _sort_by(lt, by, idx);