function shape_ellipse(axes) =
    let(
        frags = $fn > 0 ? 
            ($fn >= 3 ? $fn : 3) : 
            max(min(360 / $fa, axes[0] * 6.28318 / $fs), 5),
        step_a = 360 / frags,
        shape_pts = [
            for(a = [0:step_a:360 - step_a]) 
                [axes[0] * cos(a), axes[1] * sin(a)]
        ],
        triangles = [for(i = [1:len(shape_pts) - 2]) [0, i, i + 1]]
    )
    [
        shape_pts,
        triangles
    ];