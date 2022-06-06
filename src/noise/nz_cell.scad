/**
* nz_cell.scad
*
* @copyright Justin Lin, 2020
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-nz_cell.html
*
**/

use <_impl/_nz_cell_impl.scad>
    
function nz_cell(points, p, dist = "euclidean") =
    dist == "euclidean" ? _nz_worley_euclidean(p, points) :
    dist == "manhattan" ? _nz_worley_manhattan(p, points) :
    dist == "chebyshev" ? _nz_worley_chebyshev(p, points) : 
    dist == "border"    ? _nz_worley_border(p, points) :
    assert("Unknown distance option");