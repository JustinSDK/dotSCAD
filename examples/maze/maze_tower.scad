use <maze/mz_theta.scad>
use <util/find_index.scad>
use <arc.scad>
use <polyline2d.scad>

$fn = 48;

rings = 5;
beginning_number = 5;
cell_width = 2;

maze_tower();

module maze_tower() {
	wall_thickness = cell_width / 2;
	wall_height = cell_width * 0.75;
    half_wall_thickness = wall_thickness / 2;

	NO_WALL = 0;           
	INWARD_WALL = 1;      
	CCW_WALL = 2;         
	INWARD_CCW_WALL = 3;   

	function vt_from_angle(theta, r) = [r * cos(theta), r * sin(theta)];

	mz = mz_theta(rings, beginning_number);
	mz_leng = len(mz);
	outThetaStep = 360 / len(mz[rings - 1]);
	r = cell_width * (rings + 1);

	module maze() {
		for(rings = mz, cell = rings) {
			ri = cell[0];
			ci = cell[1];
			type = cell[2];
			thetaStep = 360 / len(mz[ri]);
			innerR = (ri + 1) * cell_width;
			outerR = (ri + 2) * cell_width;
			theta1 = thetaStep * ci;
			theta2 = thetaStep * (ci + 1);

			innerVt2 = vt_from_angle(theta2, innerR);
			outerVt2 = vt_from_angle(theta2, outerR);

			if(type == INWARD_WALL || type == INWARD_CCW_WALL) {
				if(!(ri == 0 && ci == 0)) {
					arc(innerR, [theta1, theta2], wall_thickness);
				}
			}

			if(type == CCW_WALL || type == INWARD_CCW_WALL) {
				intersection() {
					difference() {
						circle(outerR + half_wall_thickness);
						circle(innerR - half_wall_thickness);
					}
					polyline2d([innerVt2 * 0.9, outerVt2], width = wall_thickness);
				}
			}
		} 

		arc(r, 360, wall_thickness);
	}

	module maze_floors() {
		difference() {
			union() {
				for(i = [0:mz_leng - 1]) {
					rings = mz[i];
					ir = (rings[i][0] + 1) * cell_width;
					linear_extrude((mz_leng - i + 1) * wall_height)
						circle(ir + wall_thickness * 0.4999);
				}
				linear_extrude(wall_height)
					circle(r + wall_thickness * 0.4999);
			}
			translate([0, 0, -0.1])
			linear_extrude(wall_height * (mz_leng + 2), convexity = 10) 
			    maze();
		}
		last_rings = mz[mz_leng - 1];
		i = find_index(last_rings, function(cell) cell[2] == CCW_WALL || cell[2] == INWARD_CCW_WALL);
		theta1 = outThetaStep * last_rings[i][1];
		linear_extrude(wall_height)
			arc(r * 0.9999, [theta1 + outThetaStep * 0.1, theta1 + outThetaStep * 0.75], wall_thickness);
	}

	module d_stairs() {
		num_stairs = 4;
		stair_thickness = wall_thickness / 3;
		or = r + half_wall_thickness;
		for(ri = [0:2:rings * 2], si = [0:2]) {
			r = or - stair_thickness * si - wall_thickness * ri;
			translate([0, 0, wall_height * ri / 2 + wall_height / num_stairs * (si + 1)])
			linear_extrude(wall_height / num_stairs * (3 - si))
				arc(r, 360, stair_thickness, width_mode = "LINE_INWARD");
		}
	}

	difference() {
        maze_floors();
        d_stairs();
	}
}