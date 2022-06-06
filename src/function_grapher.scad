/**
* function_grapher.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-function_grapher.html
*
**/ 

use <util/reverse.scad>
use <hull_polyline3d.scad>
use <path_extrude.scad>
use <shape_circle.scad>

module function_grapher(points, thickness = 1, style = "FACES") {
    echo("`function_grapher` is deprecated since 3.1. Use `sf_thicken` instead.");

    rows = len(points);
    columns = len(points[0]);

    yi_range = [0:rows - 2];
    xi_range =  [0:columns - 2];

    half_thickness = thickness / 2;

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
                
        top_tri_faces1 = [
            for(yi = yi_range) 
                for(xi = xi_range)
                    [
                        xy_to_index(xi, yi, columns),
                        xy_to_index(xi + 1, yi + 1, columns),
                        xy_to_index(xi + 1, yi, columns)
                    ]    
        ];

        top_tri_faces2 = [
            for(yi = yi_range) 
                for(xi = xi_range)
                    [
                        xy_to_index(xi, yi, columns),
                        xy_to_index(xi, yi + 1, columns),
                        xy_to_index(xi + 1, yi + 1, columns)
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
    
    if(style == "FACES") {
        faces();
    }
    else if(style == "HULL_FACES") {
        twintri_lt = 
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
        
        for(twintri = twintri_lt) {
            tri_to_hull_faces(twintri[0], twintri[1]);
        }  
    }
    else {
        if(style == "LINES") {
            section = shape_circle(radius = half_thickness);
            for(row = points) {
                path_extrude(section, row);
            }

            for(x = [0:columns - 1]) {
                path_extrude(section, [for(y = [0:rows - 1]) points[y][x]]);
            }

            for(c = [0:columns - 2]) {
                path_extrude(section, [for(r = [0:rows - 1 - c]) points[r + c][r]]);
            }

            for(c = [0:columns - 2]) {
                path_extrude(section, [for(r = [0:rows - 1 - c]) points[r][r + c]]);
            }
        }
        else {
            for(row = points) {
                hull_polyline3d(row, thickness);
            }

            for(x = [0:columns - 1]) {
                hull_polyline3d([for(y = [0:rows - 1]) points[y][x]], thickness);
            }

            for(c = [0:columns - 2]) {
                hull_polyline3d([for(r = [0:rows - 1 - c]) points[r + c][r]], thickness);
            }
            
            for(c = [0:columns - 2]) {
                hull_polyline3d([for(r = [0:rows - 1 - c]) points[r][r + c]], thickness);
            }
        }
    }
}

// override it to test
module test_function_grapher_faces(points, faces) {

}