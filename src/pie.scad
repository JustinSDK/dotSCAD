/**
* pie.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-pie.html
*
**/

include <__comm__/__frags.scad>;
include <__comm__/__ra_to_xy.scad>;
include <__comm__/__shape_pie.scad>;
 
module pie(radius, angle) {
    polygon(__shape_pie(radius, angle));
}