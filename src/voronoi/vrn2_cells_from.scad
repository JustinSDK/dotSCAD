/**
* vrn2_cells_from.scad
*
* @copyright Justin Lin, 2020
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-vrn2_cells_from.html
*
**/

use <../triangle/tri_delaunay.scad>

function vrn2_cells_from(points) = tri_delaunay(points, ret = "VORONOI_CELLS");