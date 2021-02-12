/**
* angle_between.scad
*
* @copyright Justin Lin, 2020
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-angle_between.html
*
**/

function angle_between(vt1, vt2) = acos((vt1 * vt2) / (norm(vt1) * norm(vt2)));