/**
* sf_solidify.scad
*
* @copyright Justin Lin, 2020
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-sf_solidify.html
*
**/ 

use <../util/reverse.scad>;
use <../util/flat.scad>;

module sf_solidify(surface1, surface2, slicing = "SLASH", convexity = 1) {
    rows = len(surface1);
    columns = len(surface1[0]);

    // dimensionality reduction 
    indices = [
        for(y = [0:rows - 1])
        [for(x = [0:columns - 1]) y * columns + x]
    ]; 

    flatted_sf1 = flat(surface1);
    flatted_sf2 = flat(surface2);
    
    leng_pts = len(flatted_sf1);
            
    yi_range = [0:rows - 2];
    xi_range = [0:columns - 2];

    sf1_tri_faces1 = slicing == "SLASH" ? [
        for(yi = yi_range, xi = xi_range) 
        [
            indices[yi][xi],
            indices[yi + 1][xi + 1],
            indices[yi][xi + 1]
        ]    
    ] : [
        for(yi = yi_range, xi = xi_range)
        [
            indices[yi][xi],
            dim_reduce(xi, yi + 1, columns),
            dim_reduce(xi + 1, yi, columns)
        ]    
    ];

    sf1_tri_faces2 = slicing == "SLASH" ? [
        for(yi = yi_range, xi = xi_range) 
        [
            indices[yi][xi],
            indices[yi + 1][xi],
            indices[yi + 1][xi + 1]
        ]    
    ] : [
        for(yi = yi_range, xi = xi_range) 
        [
            indices[yi + 1][xi],
            indices[yi + 1][xi + 1],
            indices[yi][xi + 1]
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
                idx1 = indices[0][xi],
                idx2 = indices[0][xi + 1]
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
                idx1 = indices[yi][xi],
                idx2 = indices[yi + 1][xi]
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
                idx1 = indices[yi][xi], 
                idx2 = indices[yi][xi + 1]
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
                idx1 = indices[yi][0],
                idx2 = indices[yi + 1][0]
            )
            [
                idx2,
                idx1,
                idx1 + leng_pts,
                idx2 + leng_pts
            ]
    ];                  

    polyhedron(
        points = concat(flatted_sf1, flatted_sf2), 
        faces = concat(
            sf1_tri_faces1, sf1_tri_faces2,
            sf2_tri_faces1, sf2_tri_faces2, 
            side_faces1, 
            side_faces2, 
            side_faces3, 
            side_faces4
        ),
        convexity = convexity
    );
}