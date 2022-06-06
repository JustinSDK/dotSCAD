/**
* pie.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-pie.html
*
**/

include <shape_pie.scad>
 
module pie(radius, angle) {
    polygon(shape_pie(radius, angle));
}