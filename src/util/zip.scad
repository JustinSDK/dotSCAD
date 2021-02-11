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

function zip(lts, slider) = is_function(slider) ? _zipAll(lts, slider) : _zipAll(lts);