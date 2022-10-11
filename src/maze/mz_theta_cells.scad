/**
* mz_theta_cells.scad
*
* @copyright Justin Lin, 2020
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-mz_theta_cells.html
*
**/

use <_impl/_mz_theta_cells.scad>

function mz_theta_cells(rows, beginning_number, start = [0, 0], seed) =
    let(
		divided_ratio = echo("mz_theta_cells is deprecated. use maze/mz_theta instead.") 1.5,
	    before_traveled = config_nbrs(init_theta_maze(rows, beginning_number, divided_ratio)), 
        s = set_visited(before_traveled[start.x][start.y])
	)
	backtracker(
	    update_maze(before_traveled, s), start, rows, seed);
