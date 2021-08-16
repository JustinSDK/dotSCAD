/*
    A New Computationally Efficient Method for Spacing n Points on a Sphere
    Jonathan Kogan
    https://www.youtube.com/watch?v=c-6DV4ZyCdo
*/
function kogan_sphere(n, radius = 1, dir = "CT_CLK") = 
    let(
		HALF_PI = PI / 2,
        toDegrees = 180 / PI,
        clk = dir == "CT_CLK" ? 1 : -1,
	    az_unit = (0.1 + 1.2 * n) * clk,
		n_1 = n - 1,
		step = 2 / n_1 - 2 / (n_1 ^ 2),
        from = -1 + 1 / n_1,
        to = from + n_1 * step
	)
    [
	    for(sf = [from:step:to])
	    let(
			ay = HALF_PI * sign(sf) * (1 - sqrt(1 - abs(sf))) * toDegrees,
			az = (sf * az_unit) * toDegrees
		)
        radius * [
	        cos(az) * cos(ay), 
		    sin(az) * cos(ay), 
		    sin(ay)
	    ]
    ];