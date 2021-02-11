/**
* zip.scad
*
* @copyright Justin Lin, 2020
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-zip.html
*
**/ 

use <_impl/_zip_impl.scad>;

function zip(lts, zipper) = is_function(zipper) ? _zipAll(lts, zipper) : _zipAll(lts);