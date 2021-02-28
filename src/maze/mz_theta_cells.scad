use <_impl/_mz_theta_cells.scad>;

function mz_theta_cells(rows, begining_columns, divided_ratio = 1.5, seed) =
    let(
	    before_traveled = config_nbrs(init_theta_maze(rows, begining_columns, divided_ratio)), 
        start = set_visited(before_traveled[0][0])
	)
	backtracker(
	    update_maze(before_traveled, start), [0, 0], rows);
