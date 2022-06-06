/**
* nz_worley3.scad
*
* @copyright Justin Lin, 2020
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-nz_worley3.html
*
**/

use <../util/rand.scad>
use <_impl/_nz_worley3_impl.scad>

function nz_worley3(x, y, z, seed, grid_w = 10, dist = "euclidean") =
    _nz_worley3([x, y, z], seed, grid_w, dist);