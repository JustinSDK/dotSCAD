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
    // Increasing $fn will be slow when you use "LINES" or "HULL_FACES".
     
    function tri_shell_points(top) =
        let(
            z_offset = [0, 0, -thickness],
            bottom = [
                top[0] + z_offset, 
                top[1] + z_offset, 
                top[2] + z_offset
            ],
            faces = [
                [0, 1, 2],
                [3, 4, 5],
                [0, 1, 4, 3],
                [1, 2, 5, 4],
                [2, 0, 3, 5]
            ]
        )
        [
            concat(top, bottom), 
            faces
        ];
        
        
    module tri_to_faces(top_tri1, top_tri2) {
        pts_faces1 = tri_shell_points(top_tri1);
        pts_faces2 = tri_shell_points(top_tri2);
        
        hull() {
            polyhedron(
                points = pts_faces1[0], 
                faces = pts_faces1[1]
            );
            polyhedron(
                points = pts_faces2[0],
                faces = pts_faces2[1]
            );
        }
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
        if(style == "FACES") {
            tri_to_faces(tri1, tri2);
        } else if(style == "LINES") {
            tri_to_lines(tri1, tri2);
        } else {  // Warning: May be very slow!!
            tri_to_hull_faces(tri1, tri2);
        }
    }

    for(yi = [0:len(points) - 2]) {
        for(xi = [0:len(points[yi]) - 2]) {
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