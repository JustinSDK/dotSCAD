use <__comm__/__angy_angz.scad>;

function spherical_coordinate(point) = 
    let(ayz = __angy_angz([0, 0, 0], point))
    // mathematics, r, theta, phi 
    [norm(point), ayz[1], ayz[0]];