include <unittest.scad>;
include <line3d.scad>;
include <polyline3d.scad>;
include <hull_polyline3d.scad>;

module test_function_grapher_default() {
    echo("==== test_function_grapher_default ====");
    
    include <function_grapher.scad>;

    pts = [
        [[0, 0, 1], [1, 0, 2], [2, 0, 2], [3, 0, 3]],
        [[0, 1, 1], [1, 1, 4], [2, 1, 0], [3, 1, 3]],
        [[0, 2, 1], [1, 2, 3], [2, 2, 1], [3, 2, 3]],
        [[0, 3, 1], [1, 3, 3], [2, 3, 1], [3, 3, 3]]
    ];
    
    thickness = 0.5;
   
    module test_function_grapher_faces(points, faces) {
        expected_pts = concat([
            for(row = pts)
                for(pt = row)
                    pt
        ], [
            for(row = pts)
                for(pt = row)
                    pt + [0, 0, -thickness]
        ]);
    
        assertEqualPoints(expected_pts, points);

        expected_faces = [[0, 5, 1], [1, 6, 2], [2, 7, 3], [4, 9, 5], [5, 10, 6], [6, 11, 7], [8, 13, 9], [9, 14, 10], [10, 15, 11], [0, 4, 5], [1, 5, 6], [2, 6, 7], [4, 8, 9], [5, 9, 10], [6, 10, 11], [8, 12, 13], [9, 13, 14], [10, 14, 15], [17, 21, 16], [18, 22, 17], [19, 23, 18], [21, 25, 20], [22, 26, 21], [23, 27, 22], [25, 29, 24], [26, 30, 25], [27, 31, 26], [21, 20, 16], [22, 21, 17], [23, 22, 18], [25, 24, 20], [26, 25, 21], [27, 26, 22], [29, 28, 24], [30, 29, 25], [31, 30, 26], [0, 1, 17, 16], [1, 2, 18, 17], [2, 3, 19, 18], [3, 7, 23, 19], [7, 11, 27, 23], [11, 15, 31, 27], [13, 12, 28, 29], [14, 13, 29, 30], [15, 14, 30, 31], [4, 0, 16, 20], [8, 4, 20, 24], [12, 8, 24, 28]]; 
        
        for(i = [0:len(expected_faces) - 1]) {
            assert(expected_faces[i] == faces[i]);
        }        
    }
    
    function_grapher(pts, thickness);
}

test_function_grapher_default();