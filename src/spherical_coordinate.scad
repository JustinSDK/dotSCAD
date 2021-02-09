function spherical_coordinate(point) = 
    // mathematics [r, theta, phi]
    [
        norm(point), 
        atan2(point[1], point[0]), 
        atan2(point[2], sqrt(point[0]^2 + point[1]^2))
    ];
