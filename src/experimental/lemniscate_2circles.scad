use <__comm__/__frags.scad>
use <path_extrude.scad>
use <shape_circle.scad>

function lemniscate_2circles(radius, c = 1) = 
    let(
	    fn = __frags(radius),
	    t_step = 180 / fn,
	    circle_path = shape_circle(radius = radius)
	)
    concat(
		[
			for(t = [0:fn - 1]) 
			[circle_path[t][0] - radius, circle_path[t][1], cos(t * t_step) * c]
		],
		[
			for(t = [0:fn - 1]) 
			[-circle_path[t][0] + radius, circle_path[t][1], -cos(t * t_step) * c]
		]
	);

/*
use <path_extrude.scad>
use <lemniscate_2circles.scad>
	
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

$fn = 48;

path = lemniscate_2circles(10, 2);

path_extrude(
    shape_pts, 
	concat(path, [path[0]]), 
	method = "EULER_ANGLE"
);
*/