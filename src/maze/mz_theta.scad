/**
* mz_theta.scad
*
* @copyright Justin Lin, 2022
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-mz_theta.html
*
**/

use <_impl/_mz_theta_cells.scad>

function mz_theta(rings, beginning_number, start = [0, 0], seed) =
    let(
		divided_ratio = 1.5,
	    before_traveled = config_nbrs(init_theta_maze(rings, beginning_number, divided_ratio)), 
        s = set_visited(before_traveled[start.x][start.y])
	)
	backtracker(
	    update_maze(before_traveled, s), start, rings, seed);
