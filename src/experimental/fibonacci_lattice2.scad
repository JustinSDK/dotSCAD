function fibonacci_lattice2(n, radius = 1, rt_dir = "CT_CLK") =
    let(
        g = (1 + sqrt(5)) / 2,
        dir = rt_dir == "CT_CLK" ? 1 : -1
    ) 
    [
        for(i = [0:n - 1]) 
        let(
            r = sqrt(i / n),
            theta = dir * i * g * 180
        )
        [radius * r * cos(theta), radius * r * sin(theta)]
    ];


num_pts = 300;
pts = fibonacci_lattice2(num_pts);

for(p = pts) {
    translate(p)
        circle(.01, $fn = 24);
}

