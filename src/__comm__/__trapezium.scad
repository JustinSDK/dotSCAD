use <__half_trapezium.scad>

function __trapezium(length, h, round_r) =
    let(
        r_half_trapezium = __half_trapezium(length / 2, h, round_r),
        l_half_trapezium = [
            for(i = len(r_half_trapezium) - 1; i > -1; i = i - 1)
                let(pt = r_half_trapezium[i])
                [-pt.x, pt.y]
        ]
    )    
    concat(
        r_half_trapezium,
        l_half_trapezium
    );