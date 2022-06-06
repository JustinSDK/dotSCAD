/**
* polar_zonohedra.scad
*
* @copyright Justin Lin, 2021
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-polyhedra_polar_zonohedra.html
*
**/

use <geom_polar_zonohedra.scad>

module polar_zonohedra(n, theta = 35.5) {
    points_faces = geom_polar_zonohedra(n, theta);
	polyhedron(points_faces[0], points_faces[1]);
}