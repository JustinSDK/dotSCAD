function bauer_spiral(n, dir = "CT_CLK") = 
    let(
        L = sqrt(n * PI),
        toRadians = PI / 180,
        toDegrees = 180 / PI,
        clk = dir == "CT_CLK" ? 1 : -1
    )
    [
        for(k = 1; k <= n; k = k + 1)
        let(
            zk = 1 - (2 * k - 1) / n,
            phik = acos(zk) * toRadians,
            thetak = L * phik * clk,
            phikDegrees = toDegrees * phik,
            thetakDegrees = toDegrees * thetak,
            xk = sin(phikDegrees) * cos(thetakDegrees),
            yk = sin(phikDegrees) * sin(thetakDegrees)
        )
        [xk, yk, zk]
    ];