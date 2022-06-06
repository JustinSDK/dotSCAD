/**
* polygon_hull.scad
*
* @copyright Justin Lin, 2020
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-polygon_hull.html
*
**/ 

use <__comm__/_convex_hull2.scad>

module polygon_hull(points, polygon_abuse = false) {
    if(polygon_abuse) {
        // It's workable only because `polygon` doesn't complain about mis-ordered points.
        // It's fast but might be invalid in later versions.
        hull() polygon(points);
    }
    else {
        poly = _convex_hull2(points);
        polygon(poly);
        test_convex_hull2(poly);
    }
}

module test_convex_hull2(poly) {

}