function geom_star(outerRadius = 1, innerRadius =  0.381966, height = 0.5, n = 5) =
    let(
        right = 90,
        thetaStep = 360 / n,
        half_thetaStep = thetaStep / 2,
        half_height = height / 2,
        leng_star = n * 2,
        points = [
            each [
                for(i = [0:n - 1]) 
                let(
                    a = thetaStep * i + right,
                    outerPoint = [outerRadius * cos(a), outerRadius * sin(a), 0],
                    innerPoint = [innerRadius * cos(a + half_thetaStep), innerRadius * sin(a + half_thetaStep), 0]
                )
                each [outerPoint, innerPoint]
            ],
            [0, 0, half_height], 
            [0, 0, -half_height]
        ],
        faces = [
            for(i = [0:leng_star - 1]) 
                each [[leng_star, (i + 1) % leng_star, i], [i, (i + 1) % leng_star, leng_star + 1]]
        ]
    )
    [points, faces];