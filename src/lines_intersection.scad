/**
* lines_intersection2.scad
*
* @copyright Justin Lin, 2020
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-lines_intersection.html
*
**/

use <__comm__/__line_intersection.scad>;
use <__comm__/__in_line.scad>;

function lines_intersection(line1, line2, ext = false, epsilon = 0.0001) =
     let(pt = len(line1[0]) == 2 ? __line_intersection2(line1, line2, epsilon) : 
                                   __line_intersection3(line1, line2, epsilon))
     ext || pt == [] ? pt :
     __in_line(line1, pt, epsilon) && __in_line(line2, pt, epsilon) ? pt : [];