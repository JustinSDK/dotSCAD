/**
* dodecahedron.scad
*
* @copyright Justin Lin, 2021
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-polyhedra_dodecahedron.html
*
**/

use <geom_dodecahedron.scad>

module dodecahedron(radius, detail = 0) {
	points_faces = geom_dodecahedron(radius, detail);
    polyhedron(points_faces[0], points_faces[1]);
} 
