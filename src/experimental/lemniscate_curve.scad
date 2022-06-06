/*
use <lemniscate_curve.scad>
use <path_extrude.scad>
use <shape_star.scad>

shape_pts = [
    [3, -1.5],
    [3, 1.5], 
    [2, 1.5],
    [2, 0.5],
    [-2, 0.5],
    [-2, 1.5],    
    [-3, 1.5],    
	[-3, -1.5],
    [-2, -1.5],
	[-2, -0.5],
	[2, -0.5],
	[2, -1.5]
];

path_pts = lemniscate_curve(2, 1, .75, .075) * 20;
path_extrude(
    shape_pts, 
	concat(path_pts, [path_pts[0]]), 
	method = "EULER_ANGLE"
);

path_pts2 = lemniscate_curve(2, 1, .75, .2) * 20;
translate([0, 30, 0])
    path_extrude(shape_star() * 3, 
	concat(path_pts2, [path_pts2[0]]), 
	method = "EULER_ANGLE"
);


*/

// based on Lemniscate of Gerono https://en.wikipedia.org/wiki/Lemniscate#Lemniscate_of_Gerono
function lemniscate_curve(t_step, a = 2, b = 1, c = 1) = 
    [
	    for(t = [0:t_step:360 - t_step])
		let(
		    sint = sin(t),
			cost = cos(t)
		)
		[a * sint, b * sint * cost , c * cost]
	];