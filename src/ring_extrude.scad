module ring_extrude(shape_pts, radius, angle = 360, twist = 0, scale = 1.0, triangles = "RADIAL") {
    frags = $fn > 0 ? 
            ($fn >= 3 ? $fn : 3) : 
            max(min(360 / $fa, radius * 6.28318 / $fs), 5);

    angle_step = 360 / frags;
    as = [for(a = [0:angle_step:angle]) [90, 0, a]];

    angles = as[len(as) - 1][2] == angle ? as : concat(as, [[90, 0, angle]]);
    pts = [for(a = angles) [radius * cos(a[2]), radius * sin(a[2])]];

    polysections(
        cross_sections(shape_pts, pts, angles, twist, scale),
        triangles = triangles
    );
}