/**
* sorted.scad
*
* @copyright Justin Lin, 2022
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-sorted.html
*
**/ 

use <_impl/_sorted_impl.scad>

function sorted(lt, cmp = undef, key = undef, reverse = false) = 
    let(is_cmp_undef = is_undef(cmp))
    is_cmp_undef && is_undef(key) ? _sorted_default(lt, reverse) :
    is_cmp_undef ?                  _sorted_key(lt, key, reverse) :
                                    _sorted_cmp(lt, cmp, reverse);