/**
* every.scad
*
* @copyright Justin Lin, 2021
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-every.html
*
**/ 

use <_impl/_every.scad>;

function every(lt, test) = _every(lt, test, len(lt));