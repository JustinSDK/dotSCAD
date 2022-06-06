/**
* star.scad
*
* @copyright Justin Lin, 2021
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-polyhedra_star.html
*
**/

use <geom_star.scad>

module star(outerRadius = 1, innerRadius =  0.381966, height = 0.5, n = 5) {
    points_faces = geom_star(outerRadius, innerRadius, height, n);
    polyhedron(points_faces[0], points_faces[1]);
}