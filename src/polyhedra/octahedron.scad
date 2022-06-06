/**
* octahedron.scad
*
* @copyright Justin Lin, 2021
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-polyhedra_octahedron.html
*
**/

use <geom_octahedron.scad>

module octahedron(radius, detail = 0) {
	points_faces = geom_octahedron(radius, detail);
    polyhedron(points_faces[0], points_faces[1]);
} 