/**
* polyhedron_hull.scad
*
* @copyright Justin Lin, 2020
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-polyhedron_hull.html
*
**/

use <__comm__/_convex_hull3.scad>

module polyhedron_hull(points, polyhedron_abuse = false) {
    if(polyhedron_abuse) {
        // It's workable only because `polyhedron` doesn't complain about mis-ordered faces.
        // It's fast but might be invalid in later versions.
        hull()
        polyhedron(points, [[each [0:len(points) - 1]]]);
    }
    else {
        vts_faces = _convex_hull3(points);
        polyhedron(vts_faces[0], vts_faces[1]);
        test_convex_hull3(vts_faces);
    }
}

module test_convex_hull3(vts_faces) {

}