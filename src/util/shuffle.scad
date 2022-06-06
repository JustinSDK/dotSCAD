/**
* shuffle.scad
*
* @copyright Justin Lin, 2021
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-shuffle.html
*
**/ 

use <_impl/_shuffle_impl.scad>

function shuffle(lt, seed) = 
    let(
        leng = len(lt),
        indices = [for(i = is_undef(seed) ? rands(0, leng, leng) : rands(0, leng, leng, seed)) floor(i)]
    )
    _shuffle(lt, indices, leng);