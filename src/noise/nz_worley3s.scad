/**
* nz_worley3s.scad
*
* @copyright Justin Lin, 2020
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-nz_worley3s.html
*
**/

use <../util/rand.scad>
use <_impl/_nz_worley3_impl.scad>

function nz_worley3s(points, seed, grid_w = 10, dist = "euclidean") =
    let(sd = is_undef(seed) ? rand() * 1000: seed)
    _nz_worley3s(points, sd, grid_w, dist);