function fibonacci_sphere(samples) =
    let(
        toDegrees = 180 / PI,
        phi = PI * (3 - sqrt(5))
    )
    [
        for(i = [0:samples - 1])
        let(
            y = 1 - (i / (samples - 1)) * 2,
            radius = sqrt(1 - y * y),
            theta = phi * i,
            x = cos(theta * toDegrees) * radius,
            z = sin(theta * toDegrees) * radius
        )
        [x, y, z]
    ];