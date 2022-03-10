module sf_hull(points, thickness) {
    rows = len(points);
    columns = len(points[0]);

    yi_range = [0:rows - 2];
    xi_range =  [0:columns - 2];

    half_thickness = thickness / 2;

    module hull_pts(tri) {
       hull() {
           translate(tri[0]) sphere(half_thickness);
           translate(tri[1]) sphere(half_thickness);
           translate(tri[2]) sphere(half_thickness);
       }    
    }
    
    module tri_to_hull_faces(tri1, tri2) {
       hull_pts(tri1);
       hull_pts(tri2);
    }    
    
    twintri_lt = 
        [
            for(yi = yi_range, xi = xi_range)
            [
                [
                    points[yi][xi], 
                    points[yi][xi + 1], 
                    points[yi + 1][xi]
                ],
                [
                    points[yi + 1][xi], 
                    points[yi][xi + 1], 
                    points[yi + 1][xi + 1]                        
                ]
            ]
        ];

    for(twintri = twintri_lt) {
        tri_to_hull_faces(twintri[0], twintri[1]);
    }  
}