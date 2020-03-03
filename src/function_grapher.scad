/**
* function_grapher.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib2x-function_grapher.html
*
**/ 

use <util/reverse.scad>;
use <polyline3d.scad>;
use <hull_polyline3d.scad>;

module function_grapher(points, thickness, style = "FACES", slicing = "SLASH") {

    rows = len(points);
    columns = len(points[0]);

    yi_range = [0:rows - 2];
    xi_range =  [0:columns - 2];

    // Increasing $fn will be slow when you use "LINES", "HULL_FACES" or "HULL_LINES".
    
    module faces() {
        function xy_to_index(x, y, columns) = y * columns + x; 

        top_pts = [
            for(row_pts = points)
                for(pt = row_pts)
                    pt
        ];
            
        base_pts = [
            for(pt = top_pts)
                [pt[0], pt[1], pt[2] - thickness]
        ];
        
        leng_pts = len(top_pts);
                
        top_tri_faces1 = slicing == "SLASH" ? [
            for(yi = yi_range) 
                for(xi = xi_range)
                    [
                        xy_to_index(xi, yi, columns),
                        xy_to_index(xi + 1, yi + 1, columns),
                        xy_to_index(xi + 1, yi, columns)
                    ]    
        ] : [
            for(yi = yi_range)
                for(xi = xi_range)
                    [
                        xy_to_index(xi, yi, columns),
                        xy_to_index(xi, yi + 1, columns),
                        xy_to_index(xi + 1, yi, columns)
                    ]    
        ];

        top_tri_faces2 = slicing == "SLASH" ? [
            for(yi = yi_range) 
                for(xi = xi_range)
                    [
                        xy_to_index(xi, yi, columns),
                        xy_to_index(xi, yi + 1, columns),
                        xy_to_index(xi + 1, yi + 1, columns)
                    ]    
        ] : [
            for(yi = yi_range) 
                for(xi = xi_range)
                    [
                        xy_to_index(xi, yi + 1, columns),
                        xy_to_index(xi + 1, yi + 1, columns),
                        xy_to_index(xi + 1, yi, columns)
                    ]    
        ];        

        offset_v = [leng_pts, leng_pts, leng_pts];
        base_tri_faces1 = [
            for(face = top_tri_faces1)
                reverse(face) + offset_v
        ];

        base_tri_faces2 = [
            for(face = top_tri_faces2)
                reverse(face) + offset_v
        ];
        
        side_faces1 = [
            for(xi = xi_range)
                let(
                    idx1 = xy_to_index(xi, 0, columns),
                    idx2 = xy_to_index(xi + 1, 0, columns)
                )
                [
                    idx1,
                    idx2,
                    idx2 + leng_pts,
                    idx1 + leng_pts
                ]
        ];

        side_faces2 = [
            for(yi = yi_range)
                let(
                    xi = columns - 1,
                    idx1 = xy_to_index(xi, yi, columns),
                    idx2 = xy_to_index(xi, yi + 1, columns)
                )
                [
                    idx1,
                    idx2,
                    idx2 + leng_pts,
                    idx1 + leng_pts
                ]
        ];                  
      
        side_faces3 = [
            for(xi = xi_range)
                let(
                    yi = rows - 1,
                    idx1 = xy_to_index(xi, yi, columns), 
                    idx2 = xy_to_index(xi + 1, yi, columns)
                )
                [
                    idx2,
                    idx1,
                    idx1 + leng_pts,
                    idx2 + leng_pts
                ]
        ];
        
        side_faces4 = [
            for(yi = yi_range)
                let(
                    idx1 = xy_to_index(0, yi, columns),
                    idx2 = xy_to_index(0, yi + 1, columns)
                )
                [
                    idx2,
                    idx1,
                    idx1 + leng_pts,
                    idx2 + leng_pts
                ]
        ];                  
        
        pts = concat(top_pts, base_pts);
        face_idxs = concat(
                top_tri_faces1, top_tri_faces2,
                base_tri_faces1, base_tri_faces2, 
                side_faces1, 
                side_faces2, 
                side_faces3, 
                side_faces4
            );

        polyhedron(
            points = pts, 
            faces = face_idxs
        );

        // hook for testing
        test_function_grapher_faces(pts, face_idxs);
    }

    module tri_to_slash_lines(tri1, tri2) {
        polyline3d(concat(tri1, [tri1[0]]), thickness);
        if(tri2[0][0] == points[0][0][0]) {
            polyline3d([tri2[0], tri2[2]], thickness);
        }

        if(tri2[1][1] == points[rows - 1][0][1]) {
            polyline3d([tri2[1], tri2[2]], thickness);
        }
    }

    module tri_to_backslash_lines(tri1, tri2) {
        polyline3d(concat(tri1, [tri1[0]]), thickness);
        if(tri2[1][0] == points[0][columns - 1][0]) {
            polyline3d([tri2[1], tri2[2]], thickness);
        }

        if(tri2[2][1] == points[rows - 1][columns - 1][1]) {
            polyline3d([tri2[0], tri2[2]], thickness);
        }
    }

    module tri_to_slash_hull_lines(tri1, tri2) {
        hull_polyline3d(concat(tri1, [tri1[0]]), thickness);

        if(tri2[0][0] == points[0][0][0]) {
            hull_polyline3d([tri2[0], tri2[2]], thickness);
        }

        if(tri2[1][1] == points[rows - 1][0][1]) {
            hull_polyline3d([tri2[1], tri2[2]], thickness);
        }
    }  

    module tri_to_backslash_hull_lines(tri1, tri2) {
        hull_polyline3d(concat(tri1, [tri1[0]]), thickness);

        if(tri2[1][0] == points[0][columns - 1][0]) {
            hull_polyline3d([tri2[1], tri2[2]], thickness);
        }

        if(tri2[2][1] == points[rows - 1][columns - 1][1]) {
            hull_polyline3d([tri2[0], tri2[2]], thickness);
        }
    }        

    module hull_pts(tri) {
       half_thickness = thickness / 2;
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

    module tri_to_graph(twintri_lt) {
        if(style == "LINES") {
            if(slicing == "SLASH") {
                for(twintri = twintri_lt) {
                    tri_to_slash_lines(twintri[0], twintri[1]);
                }
            }
            else {
                for(twintri = twintri_lt) {
                    tri_to_backslash_lines(twintri[0], twintri[1]);
                }                
            }
        } else if(style == "HULL_FACES") {  // Warning: May be very slow!!
            for(twintri = twintri_lt) {
                tri_to_hull_faces(twintri[0], twintri[1]);
            }                  
        } else if(style == "HULL_LINES") {  // Warning: May be very slow!!
            if(slicing == "SLASH") {
                for(twintri = twintri_lt) {
                    tri_to_slash_hull_lines(twintri[0], twintri[1]);
                }                  
            }
            else {
                for(twintri = twintri_lt) {
                    tri_to_backslash_hull_lines(twintri[0], twintri[1]);
                }                    
            }
        }
    }
        
    
    if(style == "FACES") {
        faces();
    } else {
        twintri_lt = slicing == "SLASH" ? 
            [
                for(yi = yi_range)
                    for(xi = xi_range)
                        [
                            [
                                points[yi][xi], 
                                points[yi][xi + 1], 
                                points[yi + 1][xi + 1]
                            ],
                            [
                                points[yi][xi], 
                                points[yi + 1][xi + 1], 
                                points[yi + 1][xi]                            
                            ]
                        ]
            ]
            :
            [
                for(yi = yi_range)
                    for(xi = xi_range)
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
        
        tri_to_graph(twintri_lt);
    }
}

// override it to test
module test_function_grapher_faces(points, faces) {

}