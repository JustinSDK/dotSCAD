use <along_with.scad>
use <polyhedron_hull.scad>
use <maze/mz_theta.scad>
use <maze/mz_theta_get.scad>

rings = 4;
begining_columns = 6;
cell_width = 12;
rock_size = 4;
height_scale = 3;
flat_base = false;

rock_theta_maze(rings, begining_columns, cell_width, rock_size, height_scale, flat_base);

module rock(width = 1) {
	n = 15 * rands(1, 1.25, 1)[0];
	r = width / 2 * rands(1, 1.25, 1)[0];
    theta = rands(0, 359, n);
	phi = rands(0, 359, n);
	
	scale([1, 1.25, 2])
	polyhedron_hull([
	    for(i = [0:n - 1]) [r * cos(theta[i]), r * sin(theta[i]), r * cos(phi[i])]]);
}

module rock_wall(p1, p2, size) {
    dvt = p2 - p1;
    leng = norm(dvt);
	uvt = dvt / leng;
	
    along_with([for(i = [0:3:leng]) p1 + uvt * i], method = "EULER_ANGLE")
	    rock(size);
		
	translate([0, 0, 1.2])
    along_with([for(i = [0:4:leng - 1]) p1 + uvt * i], method = "EULER_ANGLE")
	    rock(size * 0.875);
}

module rock_theta_maze(rings, begining_columns, cell_width, rock_size, height_scale, flat_base) {
	function vt_from_angle(theta, r) = [r * cos(theta), r * sin(theta)];

	maze = mz_theta(rings, begining_columns);

	scale([1, 1, height_scale]) 
	difference() {
		union() {
			for(rings = maze, cell = rings) {	
				ri = mz_theta_get(cell, "r");
				ci = mz_theta_get(cell, "c");
				if([ri, ci] != [0, 0]) {
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
						rock_wall(innerVt1, innerVt2, rock_size);
					}

					if(wallType == "CCW_WALL" || wallType == "INWARD_CCW_WALL") {
						rock_wall(innerVt2, outerVt2, rock_size);
					}
				}
			}
			
			thetaStep = 360 / len(maze[rings - 1]);
			r = cell_width * (rings + 1);
			for(theta = [0:thetaStep:360 - thetaStep * 2]) {
				vt1 = vt_from_angle(theta, r);
				vt2 = vt_from_angle(theta + thetaStep, r);
				rock_wall(vt1, vt2, rock_size);
			} 
		}
		if(flat_base) {
			translate([0, 0, -cell_width * rings * 2])
				cube(cell_width * rings * 4, center = true);
		}
	}
}