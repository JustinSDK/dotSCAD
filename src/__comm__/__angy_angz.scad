function __angy_angz(p1, p2) = 
    let(
        dx = p2.x - p1.x,
        dy = p2.y - p1.y,
        dz = p2.z - p1.z
    ) 
    [
        atan2(dz, sqrt(dx ^ 2 + dy ^ 2)), 
        atan2(dy, dx)
    ];