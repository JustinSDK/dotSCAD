function __trapezium(length, h, round_r) =
    let(
        r_half_trapezium = __half_trapezium(length / 2, h, round_r),
        to = len(r_half_trapezium) - 1,
        l_half_trapezium = [
            for(i = [0:to]) 
                let(pt = r_half_trapezium[to - i])
                [-pt[0], pt[1]]
        ]
    )    
    concat(
        r_half_trapezium,
        l_half_trapezium
    );