/**
* nz_cell.scad
*
* @copyright Justin Lin, 2020
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib2x-nz_cell.html
*
**/

use <noise/_impl/_nz_cell_impl.scad>;
    
function nz_cell(points, p, dist = "euclidean") =
    dist == "border" ? _nz_cell_border(points, p) :
                       _nz_cell_classic(points, p, dist); 