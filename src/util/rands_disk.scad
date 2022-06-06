function rands_disk(radius, value_count, seed = undef) =
    let(
	    seed_undef = is_undef(seed),
		n = value_count * 2,
	    theta = seed_undef ? rands(0, 360, n) : rands(0, 360, n, seed),
		k = radius ^ 2 * (seed_undef ? rands(0, 1, n) : rands(0, 1, n, seed))
	)
	[
	    for(i = [0:value_count - 1])
		[cos(theta[i]), sin(theta[i])] * sqrt(k[i])
	];
	
/*
use <util/rands_disk.scad>

number = 10000;
radius = 2;

points = rands_disk(radius, number);

for(p = points) {
    translate(p)
	    circle(.01);
}

%circle(radius, $fn = 96);*/