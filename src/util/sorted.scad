/**
* sort.scad
*
* @copyright Justin Lin, 2022
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-sorted.html
*
**/ 

use <_impl/_sorted_impl.scad>;

function sorted(lt, cmp = undef, key = undef) = 
    !is_undef(cmp) ? _sorted_cmp(lt, cmp) :
    !is_undef(key) ? _sorted_key(lt, key) :
                     _sorted_default(lt);