/**
* function_grapher.scad
*
* 
* Given a set of points `[x, y, f(x, y)]` where `f(x, y)` is a 
* mathematics function, the `function_grapher` module can 
* create the graph of `f(x, y)`.
* It depends on the line3d and polyline3d modules so you have 
* to include "line3d.scad" and "polyline3d.scad".
* 
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-function_grapher.html
*
**/ 

module function_grapher(points, thickness, style = "FACES", slicing = "SLASH") {

    rows = len(points);
    columns = len(points[0]);

    // Increasing $fn will be slow when you use "LINES" or "HULL_FACES".
    
    module faces() {
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
            for(yi = [0:rows - 2]) 
                for(xi = [0:columns - 2])
                    [
                        xy_to_index(xi, yi, columns),
                        xy_to_index(xi + 1, yi + 1, columns),
                        xy_to_index(xi + 1, yi, columns)
                    ]    
        ] : [
            for(yi = [0:rows - 2]) 
                for(xi = [0:columns - 2])
                    [
                        xy_to_index(xi, yi, columns),
                        xy_to_index(xi, yi + 1, columns),
                        xy_to_index(xi + 1, yi, columns)
                    ]    
        ];

        top_tri_faces2 = slicing == "SLASH" ? [
            for(yi = [0:rows - 2]) 
                for(xi = [0:columns - 2])
                    [
                        xy_to_index(xi, yi, columns),
                        xy_to_index(xi, yi + 1, columns),
                        xy_to_index(xi + 1, yi + 1, columns)
                    ]    
        ] : [
            for(yi = [0:rows - 2]) 
                for(xi = [0:columns - 2])
                    [
                        xy_to_index(xi, yi + 1, columns),
                        xy_to_index(xi + 1, yi + 1, columns),
                        xy_to_index(xi + 1, yi, columns)
                    ]    
        ];        
        
        leng_tri_faces = len(top_tri_faces1); 

        base_tri_faces1 = [
            for(i = [0:leng_tri_faces - 1])
                top_tri_faces1[leng_tri_faces - 1 - i] + [leng_pts, leng_pts, leng_pts, leng_pts]
        ];

        base_tri_faces2 = [
            for(i = [0:leng_tri_faces - 1])
                top_tri_faces2[leng_tri_faces - 1 - i] + [leng_pts, leng_pts, leng_pts, leng_pts]
        ];
        
        side_faces1 = [
            for(xi = [0:columns - 2])
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
            for(yi = [0:rows - 2])
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
            for(xi = [0:columns - 2])
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
            for(yi = [0:rows - 2])
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
        
        polyhedron(
            points = concat(top_pts, base_pts), 
            faces = concat(
                top_tri_faces1, top_tri_faces2,
                base_tri_faces1, base_tri_faces2, 
                side_faces1, 
                side_faces2, 
                side_faces3, 
                side_faces4
            )
        );    
    }

    module tri_to_lines(tri1, tri2) {
       polyline3d(concat(tri1, [tri1[0]]), thickness);
       polyline3d(concat(tri2, [tri2[0]]), thickness);
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

    module tri_to_graph(tri1, tri2) {
        if(style == "LINES") {
            tri_to_lines(tri1, tri2);
        } else {  // Warning: May be very slow!!
            tri_to_hull_faces(tri1, tri2);
        }
    }
    
    function xy_to_index(x, y, columns) = y * columns + x; 
    

    
    if(style == "FACES") {
        faces();
    } else {
        for(yi = [0:rows - 2]) {
            for(xi = [0:columns - 2]) {
                if(slicing == "SLASH") {
                    tri_to_graph([
                        points[yi][xi], 
                        points[yi][xi + 1], 
                        points[yi + 1][xi + 1]
                    ], [
                        points[yi][xi], 
                        points[yi + 1][xi + 1], 
                        points[yi + 1][xi]
                    ]);
                } else {                
                    tri_to_graph([
                        points[yi][xi], 
                        points[yi][xi + 1], 
                        points[yi + 1][xi]
                    ], [
                        points[yi + 1][xi], 
                        points[yi][xi + 1], 
                        points[yi + 1][xi + 1]
                    ]);                    
                }        
            }
        }
    }
}