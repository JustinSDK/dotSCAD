/**
* polar_coordinate.scad
*
* @copyright Justin Lin, 2020
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-polar_coordinate.html
*
**/ 

use <../__comm__/__angy_angz.scad>;

function polar_coordinate(point) = [norm(point), atan2(point[1], point[0])]; // r, theta 