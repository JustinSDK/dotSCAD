/**
* some.scad
*
* @copyright Justin Lin, 2021
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-some.html
*
**/ 

use <_impl/_some.scad>;

function some(lt, test) = _some(lt, test, len(lt));