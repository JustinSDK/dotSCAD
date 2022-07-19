function fibonacci_lattice2(n, radius = 1, rt_dir = "CT_CLK") =
    let(
        g = 2/ (1 + sqrt(5)),
        dir = rt_dir == "CT_CLK" ? -1 : 1
    ) 
    [
        for(i = [0:n - 1]) 
        let(
            k = i + 0.5,
            r = sqrt(k / n),
            theta = dir * k * g * 360
        )
        [radius * r * cos(theta), radius * r * sin(theta)]
    ];

num_pts = 300;
pts = fibonacci_lattice2(num_pts);

for(p = pts) {
    translate(p)
        circle(.01, $fn = 24);
}

