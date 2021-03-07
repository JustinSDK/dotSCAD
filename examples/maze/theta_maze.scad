use <maze/mz_theta_cells.scad>;
use <maze/mz_theta_get.scad>;
use <hull_polyline2d.scad>;

rows = 16;
begining_columns = 8;
cell_width = 10;
wall_thickness = 2;
wall_height = 5;

theta_maze(rows, begining_columns, cell_width, wall_thickness, wall_height);

module theta_maze(rows, begining_columns, cell_width, wall_thickness, wall_height) {

	function vt_from_angle(theta, r) = [r * cos(theta), r * sin(theta)];

	maze = mz_theta_cells(rows, begining_columns);

	linear_extrude(wall_height) {
		for(rows = maze) {
			for(cell = rows) {
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
					hull_polyline2d([innerVt1, innerVt2], width = wall_thickness);
				}

				if(wallType == "CCW_WALL" || wallType == "INWARD_CCW_WALL") {
					hull_polyline2d([innerVt2, outerVt2], width = wall_thickness);
				}
			} 
		}
		
		thetaStep = 360 / len(maze[rows - 1]);
		r = cell_width * (rows + 1);
		for(theta = [0:thetaStep:360 - thetaStep]) {
			vt1 = vt_from_angle(theta, r);
			vt2 = vt_from_angle(theta + thetaStep, r);
			hull_polyline2d([vt1, vt2], width = wall_thickness);
		} 
	}
}