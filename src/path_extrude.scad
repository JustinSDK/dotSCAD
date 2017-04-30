module path_extrude(shape_pts, points, triangles = "RADIAL") {
    function first_section() = 
        let(
            p1 = points[0],
            p2 = points[1],
            dx = p2[0] - p1[0],
            dy = p2[1] - p1[1],
            dz = p2[2] - p1[2],
            ay = 90 - atan2(dz, sqrt(pow(dx, 2) + pow(dy, 2))),
            az = atan2(dy, dx)
        )
        [
            for(p = shape_pts) 
                rotate_p(p, [0, ay, az]) + p1
        ];
    

    function section(p1, p2) = 
        let(
            dx = p2[0] - p1[0],
            dy = p2[1] - p1[1],
            dz = p2[2] - p1[2],
            length = sqrt(pow(dx, 2) + pow(dy, 2) + pow(dz, 2)),
            ay = 90 - atan2(dz, sqrt(pow(dx, 2) + pow(dy, 2))),
            az = atan2(dy, dx)
        )
        [
            for(p = shape_pts) 
                rotate_p(p + [0, 0, length], [0, ay, az]) + p1
        ];
    

    len_pts = len(points);
    
    function path_extrude_inner(index) =
       index == len_pts ? [] :
           concat(
               [section(points[index - 1], points[index])],
               path_extrude_inner(index + 1)
           );

    polysections(
        concat([first_section()], path_extrude_inner(1)),
        triangles = triangles
    );    
}
