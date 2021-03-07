/**
* mz_theta_get.scad
*
* @copyright Justin Lin, 2020
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-mz_theta_get.html
*
**/

function mz_theta_get(cell, query) = 
    let(
        i = search(query, [
            ["r", 0],
            ["c", 1],
            ["t", 2]
 	    ])[0]
    )
    i != 2 ? cell[i] : ["NO_WALL", "INWARD_WALL", "CCW_WALL", "INWARD_CCW_WALL"][cell[i]];