/**
* nz_perlin3s.scad
*
* @copyright Justin Lin, 2020
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib2x-nz_perlin3s.html
*
**/

use <../util/rand.scad>;
use <_impl/_pnoise3_impl.scad>;

function nz_perlin3s(points, seed) = 
    let(sd = is_undef(seed) ? floor(rand(0, 256)) : seed % 256)
    [for(p = points) _pnoise3(p[0], p[1], p[2], sd)];    