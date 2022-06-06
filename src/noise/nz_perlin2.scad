/**
* nz_perlin2.scad
*
* @copyright Justin Lin, 2020
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-nz_perlin2.html
*
**/

use <../util/rand.scad>
use <_impl/_pnoise2_impl.scad>

function nz_perlin2(x, y, seed) = _pnoise2(x, y, seed);