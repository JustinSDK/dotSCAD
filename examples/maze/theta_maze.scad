use <maze/mz_theta.scad>
use <maze/mz_theta_get.scad>
use <polyline_join.scad>

rings = 5;
beginning_number = 8;
cell_width = 10;
wall_thickness = 2;
wall_height = 5;

theta_maze(rings, beginning_number, cell_width, wall_thickness, wall_height);

module theta_maze(rings, beginning_number, cell_width, wall_thickness, wall_height) {

	function vt_from_angle(theta, r) = [r * cos(theta), r * sin(theta)];

	maze = mz_theta(rings, beginning_number);

    half_wall_thickness = wall_thickness / 2;
	linear_extrude(wall_height) {
		for(rings = maze, cell = rings) {
			ri = mz_theta_get(cell, "r");
			ci = mz_theta_get(cell, "c");
			wallType = mz_theta_get(cell, "t");
			thetaStep = 360 / len(maze[ri]);
			innerR = (ri + 1) * cell_width;
			outerR = (ri + 2) * cell_width;
			theta1 = thetaStep * ci;
			theta2 = thetaStep * (ci + 1);
			
			innerVt1 = vt_from_angle(theta1, innerR);
			innerVt2 = vt_from_angle(theta2, innerR);
			outerVt2 = vt_from_angle(theta2, outerR);
			
			if(wallType == "INWARD_WALL" || wallType == "INWARD_CCW_WALL") {
				polyline_join([innerVt1, innerVt2])
					circle(half_wall_thickness);
			}

			if(wallType == "CCW_WALL" || wallType == "INWARD_CCW_WALL") {
				polyline_join([innerVt2, outerVt2])
					circle(half_wall_thickness);
			}
		}
		
		thetaStep = 360 / len(maze[rings - 1]);
		r = cell_width * (rings + 1);
		for(theta = [0:thetaStep:360 - thetaStep]) {
			vt1 = vt_from_angle(theta, r);
			vt2 = vt_from_angle(theta + thetaStep, r);
			polyline_join([vt1, vt2])
			    circle(half_wall_thickness);
		} 
	}
}