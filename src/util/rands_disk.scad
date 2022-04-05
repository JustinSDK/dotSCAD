function rands_disk(radius, value_count, seed = undef) =
    let(
	    seed_undef = is_undef(seed),
	    theta = seed_undef ? rands(0, 360, value_count * 2) :  rands(0, 360, value_count * 2, seed),
		k = seed_undef ? rands(0, 1, value_count * 2) : rands(0, 1, value_count * 2, seed)
		
	)
	[
	    for(i = [0:value_count - 1])
		let(r = sqrt(k[i]) * radius)
		[cos(theta[i]), sin(theta[i])] * r
	];
	
/*
number = 10000;
radius = 2;

points = rand_pts_circle(radius, number);

for(p = points) {
    translate(p)
	    circle(.01);
}

%circle(radius, $fn = 96);*/