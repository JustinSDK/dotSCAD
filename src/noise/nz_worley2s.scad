/**
* nz_worley2s.scad
*
* @copyright Justin Lin, 2020
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib2x-nz_worley2s.html
*
**/

use <util/rand.scad>;
use <noise/_impl/_nz_worley2_impl.scad>;

function nz_worley2s(points, seed, grid_w = 10, dist = "euclidean") =
    let(sd = is_undef(seed) ? floor(rand(0, 256)) : seed % 256)
    [for(p = points) _nz_worley2(p, sd, grid_w, dist)];