function fibonacci_sphere(n, dir = "CT_CLK") =
    let(
        toDegrees = 180 / PI,
        phi = PI * (3 - sqrt(5)),
        clk = dir == "CT_CLK" ? 1 : -1
    )
    [
        for(i = [0:n - 1])
        let(
            z = 1 - (2* i + 1) / n,
            r = sqrt(1 - z * z),
            theta = phi * i * clk,
            x = cos(theta * toDegrees) * r,
            y = sin(theta * toDegrees) * r
        )
        [x, y, z]
    ];