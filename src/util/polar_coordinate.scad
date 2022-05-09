/**
* polar_coordinate.scad
*
* @copyright Justin Lin, 2020
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-polar_coordinate.html
*
**/ 

function polar_coordinate(point) = point == [0, 0] ? point : [norm(point), atan2(point.y, point.x)]; // r, theta 