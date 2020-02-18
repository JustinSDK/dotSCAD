/**
* sf_solidify.scad
*
* @copyright Justin Lin, 2020
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib2x-sf_solidify.html
*
**/ 

use <util/reverse.scad>;
use <experimental/flat.scad>;

module sf_solidify(surface1, surface2, slicing = "SLASH") {
    rows = len(surface1);
    columns = len(surface1[0]);

    yi_range = [0:rows - 2];
    xi_range =  [0:columns - 2];

    module faces() {
        function xy_to_index(x, y, columns) = y * columns + x; 

        flatted_sf1 = flat(surface1);
        flatted_sf2 = flat(surface2);
        
        leng_pts = len(flatted_sf1);
                
        sf1_tri_faces1 = slicing == "SLASH" ? [
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

        sf1_tri_faces2 = slicing == "SLASH" ? [
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
        sf2_tri_faces1 = [
            for(face = sf1_tri_faces1)
                reverse(face) + offset_v
        ];

        sf2_tri_faces2 = [
            for(face = sf1_tri_faces2)
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
        
        pts = concat(flatted_sf1, flatted_sf2);
        face_idxs = concat(
                sf1_tri_faces1, sf1_tri_faces2,
                sf2_tri_faces1, sf2_tri_faces2, 
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
        test_surface_grapher_faces(pts, face_idxs);
    }

    faces();
}

// override it to test
module test_surface_grapher_faces(surface1, faces) {

}