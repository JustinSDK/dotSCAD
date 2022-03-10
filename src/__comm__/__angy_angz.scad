function __angy_angz(p1, p2) = 
    let(v = p2 - p1) 
    [
        atan2(v.z, sqrt(v.x ^ 2 + v.y ^ 2)), 
        atan2(v.y, v.x)
    ];