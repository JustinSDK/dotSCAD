use <along_with.scad>;
use <polyhedron_hull.scad>;
use <maze/mz_theta_cells.scad>;
use <maze/mz_theta_get.scad>;

rows = 4;
begining_columns = 6;
cell_width = 10;
rock_size = 4;

rock_theta_maze(rows, begining_columns, cell_width);

module rock(width = 1) {
	n = 15 * rands(1, 1.25, 1)[0];
	r = width / 2 * rands(1, 1.25, 1)[0];
    theta = rands(0, 359, n);
	phi = rands(0, 359, n);
	
	scale([1, 1.25, 2])
	polyhedron_hull([
	    for(i = [0:n - 1]) [r * cos(theta[i]), r * sin(theta[i]), r * cos(phi[i])]]);
}

module rock_wall(p1, p2) {
    dvt = p2 - p1;
    leng = norm(dvt);
	uvt = dvt / leng;
	
    along_with([for(i = [0:3:leng]) p1 + uvt * i], method = "EULER_ANGLE")
	    rock(rock_size);
		
	translate([0, 0, 1.2])
    along_with([for(i = [0:4:leng - 1]) p1 + uvt * i], method = "EULER_ANGLE")
	    rock(rock_size * 0.875);
}

module rock_theta_maze(rows, begining_columns, cell_width) {

	function vt_from_angle(theta, r) = [r * cos(theta), r * sin(theta)];

	maze = mz_theta_cells(rows, begining_columns);

	{
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
				
					rock_wall(innerVt1, innerVt2);
				}

				if(wallType == "CCW_WALL" || wallType == "INWARD_CCW_WALL") {
				    rock_wall(innerVt2, outerVt2);
				}
			} 
		}
		
		thetaStep = 360 / len(maze[rows - 1]);
		r = cell_width * (rows + 1);
		for(theta = [0:thetaStep:360 - thetaStep]) {
			vt1 = vt_from_angle(theta, r);
			vt2 = vt_from_angle(theta + thetaStep, r);
			rock_wall(vt1, vt2);
		} 
	}
}