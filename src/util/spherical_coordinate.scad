/**
* spherical_coordinate.scad
*
* @copyright Justin Lin, 2020
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-spherical_coordinate.html
*
**/ 

function spherical_coordinate(point) = 
    // mathematics [r, theta, phi]
    point == [0, 0, 0] ? point :
    let(r = norm(point))
    [
        r, 
        atan2(point.y, point.x), 
        acos(point.z / r)
    ];