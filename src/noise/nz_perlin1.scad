/**
* nz_perlin1.scad
*
* @copyright Justin Lin, 2020
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-nz_perlin1.html
*
**/

use <_impl/_pnoise1_impl.scad>

function nz_perlin1(x, seed) = _pnoise1_impl(x, seed);