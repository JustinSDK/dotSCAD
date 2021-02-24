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

function zip(lts, combine) = is_function(combine) ? _zipAll(lts, combine) : _zipAll(lts);