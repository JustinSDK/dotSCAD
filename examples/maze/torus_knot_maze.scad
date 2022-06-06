use <polyline_join.scad>
use <maze/mz_square.scad>
use <maze/mz_squarewalls.scad>
use <path_extrude.scad>
use <torus_knot.scad>
use <ptf/ptf_rotate.scad>
use <shape_square.scad>
use <util/spherical_coordinate.scad>

p = 2;
q = 3;
phi_step = 0.05;
rows = 6;
wall_thickness = 1.25;
filled = true;
filled_thickness = wall_thickness * .25;

torus_knot_maze();

module torus_knot_maze() {
    cell_width = 1;
    torus_knot_path = torus_knot(p, q, phi_step) * rows;
    columns = len(torus_knot_path);
	path = [each torus_knot_path, torus_knot_path[0]];

    angle_yz_path = [
		for(i = [0:len(path) - 2]) 
		let(
		    v = path[i + 1] - path[i], 
		    s = spherical_coordinate(v),
			theta = s[1],
			phi = s[2]
		)
		[90 - phi, theta]
	];
	
	angle_yz = [each angle_yz_path, angle_yz_path[0]];

    walls = mz_squarewalls(
                mz_square(rows, columns, x_wrapping = true), 
                cell_width, left_border = false
            );

    half_row = rows / 2;
	r = wall_thickness / 2;
    for(wall = walls) {
	    polyline_join([
		for(p = wall) 
			let(
				x = p[0],
				y = p[1]
			)
			path[x] + ptf_rotate(
				ptf_rotate(
					[-y + half_row, 0, 0], 
					[0, 0, -90]
				), 
				[0, angle_yz[x][0], angle_yz[x][1]]
			)
		]) sphere(r, $fn = 4);
    }

    if(filled) {
		path_extrude(
			shape_square(size = [rows, filled_thickness]), 
			path, 
			closed = true,
			method = "EULER_ANGLE"
		);
	}
}