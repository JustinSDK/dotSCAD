/**
* contours.scad
*
* @copyright Justin Lin, 2020
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-contours.html
*
**/

use <_impl/_contours_impl.scad>

function contours(points, threshold) = 
    is_undef(threshold[1]) ? 
        _marching_squares_isolines(points, threshold) :
        _marching_squares_isobands(points, threshold[0], threshold[1]);