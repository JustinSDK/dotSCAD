use <ptf/ptf_rotate.scad>

function ptf_c2sphere(point, radius) = 
    let(
	    za = atan2(point[1], point[0]),
		ya = 90 * norm(point) / radius
	)
	ptf_rotate([radius * sin(ya), 0, radius * cos(ya)], za);

/*
use <experimental/tile_penrose3.scad>
use <experimental/ptf_c2sphere.scad>

r_circle = 19;
points = [
    for(r = [1:r_circle]) 
	    for(a = [0:30:330])
            [r * cos(a), r * sin(a)]		
];

radius = 10;
for(p = points) {
    #translate(p)
	    sphere(1);
		
    translate(ptf_c2sphere(p, radius))
	    sphere(1);
}
*/