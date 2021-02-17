/**
* polygon_hull.scad
*
* @copyright Justin Lin, 2020
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-polygon_hull.html
*
**/ 

use <__comm__/_convex_hull2.scad>;

module polygon_hull(points) {
    polygon(_convex_hull2(points));
}