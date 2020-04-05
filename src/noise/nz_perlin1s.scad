/**
* nz_perlin1s.scad
*
* @copyright Justin Lin, 2020
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib2x-nz_perlin1s.html
*
**/

use <util/rand.scad>;
use <noise/_impl/_pnoise1_impl.scad>;

function nz_perlin1s(xs, seed) = 
    let(sd = is_undef(seed) ? floor(rand(0, 256)) : seed % 256)
    [for(x = xs) _pnoise1_impl(x, sd)];