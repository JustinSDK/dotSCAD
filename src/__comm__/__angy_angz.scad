function __angy_angz(p1, p2) = 
    let(v = p2 - p1) 
    [
        atan2(v.z, norm([v.x, v.y])), 
        atan2(v.y, v.x)
    ];