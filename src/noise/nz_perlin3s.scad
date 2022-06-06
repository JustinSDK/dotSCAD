/**
* nz_perlin3s.scad
*
* @copyright Justin Lin, 2020
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-nz_perlin3s.html
*
**/

use <../util/rand.scad>
use <_impl/_pnoise3_impl.scad>

function nz_perlin3s(points, seed) = 
    let(sd = is_undef(seed) ? rand() * 1000 : seed)
    [for(p = points) _pnoise3(p.x, p.y, p.z, sd)];    