use <hull_polyline3d.scad>;
use <maze/mz_square_cells.scad>;
use <maze/mz_square_walls.scad>;
use <path_extrude.scad>;
use <torus_knot.scad>;
use <ptf/ptf_rotate.scad>;
use <shape_square.scad>;
use <util/spherical_coordinate.scad>;

p = 2;
q = 3;
phi_step = 0.05;
rows = 6;
wall_thickness = 1;
filled = true;

torus_knot_maze();

module torus_knot_maze() {
    cell_width = 1;
    torus_knot_path = torus_knot(p, q, phi_step) * rows;
    columns = len(torus_knot_path);
	path = concat(torus_knot_path, [torus_knot_path[0]]);

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
	
	angle_yz = concat(angle_yz_path, [angle_yz_path[0]]);

    walls = mz_square_walls(
                mz_square_cells(rows, columns, x_wrapping = true), 
                rows, columns, cell_width, left_border = false
            );

    half_row = rows / 2;
	
    for(wall = walls) {
        hull_polyline3d([
            for(p = wall) 
                let(
                    x = p[0],
                    y = p[1]
                )
                path[x] + ptf_rotate(
				    ptf_rotate(
					    [y - half_row, 0, 0], 
						[0, 0, -90]
					), 
					[0, angle_yz[x][0], angle_yz[x][1]]
			    )
            ],
            wall_thickness, 
            $fn = 4
        );
    }

    if(filled) {
		path_extrude(
			shape_square(size = [rows, wall_thickness * .05]), 
			path, 
			closed = true,
			method = "EULER_ANGLE"
		);
	}
}