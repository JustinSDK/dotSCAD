/**
* polyhedron_hull.scad
*
* @copyright Justin Lin, 2020
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib2x-polyhedron_hull.html
*
**/

use <__comm__/_convex_hull3.scad>;

module polyhedron_hull(points) {
    vts_faces = _convex_hull3(points);
    polyhedron(vts_faces[0], vts_faces[1]);
}