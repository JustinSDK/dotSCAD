/**
* shape_star.scad
*
* Returns shape points of a starburst.
* They can be used with xxx_extrude modules of dotSCAD.
* The shape points can be also used with the built-in polygon module. 
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-shape_starburst.html
*
**/

function __outer_points(r1, r2, n) = 
    let(
        a = 360 / n
    )
    [for(i = [0:n-1]) [r1 * cos(a * i), r1 * sin(a * i)]];
function __inner_points(r1, r2, n) = 
    let (
        a = 360 / n,
        half_a = a / 2
    )
    [for(i = [0:n-1]) [r2 * cos(a * i + half_a), r2 * sin(a * i + half_a)]];
    
function __one_by_one(outer_points, inner_points, i = 0) =
        len(outer_points) == i ? [] :
        concat([outer_points[i], inner_points[i]], __one_by_one(outer_points, inner_points, i + 1));    

function shape_starburst(r1, r2, n) = __one_by_one(__outer_points(r1, r2, n), __inner_points(r1, r2, n));