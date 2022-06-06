/**
* nz_perlin2s.scad
*
* @copyright Justin Lin, 2020
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-nz_perlin2s.html
*
**/

use <../util/rand.scad>
use <_impl/_pnoise2_impl.scad>

function nz_perlin2s(points, seed) = 
    let(sd = is_undef(seed) ? rand() * 1000 : seed)
    [for(p = points) _pnoise2(p.x, p.y, sd)];    