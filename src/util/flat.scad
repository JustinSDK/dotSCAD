/**
* flat.scad
*
* @copyright Justin Lin, 2020
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-flat.html
*
**/ 

function flat(lt, depth = 1) =
    depth == 1 ? [for(row = lt) each row] :
                 [for(row = lt) each flat(row, depth - 1)];