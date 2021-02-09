use <__comm__/__angy_angz.scad>;

function polar_coordinate(point) = [norm(point), atan2(point[1], point[0])]; // r, theta 