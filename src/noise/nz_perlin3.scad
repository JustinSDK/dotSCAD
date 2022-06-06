/**
* nz_perlin3.scad
*
* @copyright Justin Lin, 2020
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-nz_perlin3.html
*
**/

use <../util/rand.scad>
use <_impl/_pnoise3_impl.scad>

function nz_perlin3(x, y, z, seed) = _pnoise3(x, y, z, seed);