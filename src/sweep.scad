/**
* sweep.scad
*
* @copyright Justin Lin, 2020
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-sweep.html
*
**/

use <util/reverse.scad>;
use <util/slice.scad>;

module sweep(sections, triangles = "SOLID") {

    function side_indexes(sects, begin_idx = 0) = 
        let(       
            leng_sects = len(sects),
            leng_pts_sect = len(sects[0]),
            range_j = [begin_idx:leng_pts_sect:begin_idx + (leng_sects - 2) * leng_pts_sect],
            range_i = [0:leng_pts_sect - 1]
        ) 
        concat(
            [
                for(j = range_j, i = range_i)
                [
                    j + i, 
                    j + (i + 1) % leng_pts_sect, 
                    j + (i + 1) % leng_pts_sect + leng_pts_sect
                ]
            ],
            [
                for(j = range_j, i = range_i)
                [
                    j + i, 
                    j + (i + 1) % leng_pts_sect + leng_pts_sect , 
                    j + i + leng_pts_sect
                ]
            ]      
        );

    function the_same_after_twisting(f_sect, l_sect, leng_pts_sect) =
        let(found = search([l_sect[0]], f_sect)[0])
        found != [] && found != 0 && l_sect == concat(slice(f_sect, found), slice(f_sect, 0, found));

    function to_v_pts(sects) = [for(sect = sects) each sect];                   

    module solid_sections(sects) {
        leng_sects = len(sects);
        leng_pts_sect = len(sects[0]);
        first_sect = sects[0];
        last_sect = sects[leng_sects - 1];
   
        v_pts = to_v_pts(sects);

        begin_end_the_same =
            first_sect == last_sect || the_same_after_twisting(first_sect, last_sect, leng_pts_sect);

        if(begin_end_the_same) {
            f_idxes = side_indexes(sects);

            polyhedron(
                v_pts, 
                f_idxes
            ); 

            // hook for testing
            test_sweep_solid(v_pts, f_idxes, triangles);
        } else {
            first_idxes = [each [leng_pts_sect - 1:-1:0]];
           
            from = leng_pts_sect * (leng_sects - 1);
            to = from + leng_pts_sect - 1;
            last_idxes = [each [from:to]];    
            
            f_idxes = [first_idxes, each side_indexes(sects), last_idxes];
            
            polyhedron(
                v_pts, 
                f_idxes
            );   

            // hook for testing
            test_sweep_solid(v_pts, f_idxes, triangles);             
        }
    }

    module hollow_sections(sects) {
        leng_sects = len(sects);
        leng_sect = len(sects[0]);
        half_leng_sect = leng_sect / 2;
        half_leng_v_pts = leng_sects * half_leng_sect;

        function strip_sects(begin_idx, end_idx) = 
            let(range = [begin_idx:end_idx])
            [for(sect = sects) [for(j = range) sect[j]]]; 

        range = [0:half_leng_sect - 1];
        function first_idxes() = 
            [
                for(i = range) 
                [
                    i,
                    i + half_leng_v_pts,
                    (i + 1) % half_leng_sect + half_leng_v_pts, 
                    (i + 1) % half_leng_sect
                ] 
            ];

        function last_idxes(begin_idx) = 
            [
                for(i = range) 
                [
                    begin_idx + i,
                    begin_idx + (i + 1) % half_leng_sect,
                    begin_idx + (i + 1) % half_leng_sect + half_leng_v_pts,
                    begin_idx + i + half_leng_v_pts
                ]     
            ];            

        outer_sects = strip_sects(0, half_leng_sect - 1);
        inner_sects = strip_sects(half_leng_sect, leng_sect - 1);

        outer_idxes = side_indexes(outer_sects);
        inner_idxes = [for(idxes = side_indexes(inner_sects, half_leng_v_pts)) reverse(idxes)];

        first_outer_sect = outer_sects[0];
        last_outer_sect = outer_sects[leng_sects - 1];
        first_inner_sect = inner_sects[0];
        last_inner_sect = inner_sects[leng_sects - 1];
        
        leng_pts_sect = len(first_outer_sect);

        begin_end_the_same = 
           (first_outer_sect == last_outer_sect && first_inner_sect == last_inner_sect) ||
           (
               the_same_after_twisting(first_outer_sect, last_outer_sect, leng_pts_sect) && 
               the_same_after_twisting(first_inner_sect, last_inner_sect, leng_pts_sect)
           ); 

        v_pts = concat(to_v_pts(outer_sects), to_v_pts(inner_sects));

        if(begin_end_the_same) {
            f_idxes = concat(outer_idxes, inner_idxes);

            polyhedron(
                v_pts,
                f_idxes
            );      

            // hook for testing
            test_sweep_solid(v_pts, f_idxes, triangles);                     
        } else {
            first_idxes = first_idxes();
            last_idxes = last_idxes(half_leng_v_pts - half_leng_sect);

            f_idxes = concat(first_idxes, outer_idxes, inner_idxes, last_idxes);
            
            polyhedron(
                v_pts,
                f_idxes
            ); 

            // hook for testing
            test_sweep_solid(v_pts, f_idxes, triangles);              
        }
    }
    
    module triangles_defined_sections() {
        module tri_sections(tri1, tri2) {
            polyhedron(
                points = concat(tri1, tri2),
                faces = [
                    [0, 1, 2], 
                    [3, 5, 4], 
                    [1, 3, 4], [2, 1, 4], [2, 3, 0], 
                    [0, 3, 1], [2, 4, 5], [2, 5, 3]
                ]
            );  
        }

        module two_sections(section1, section2) {
            for(idx = triangles) {
                tri_sections(
                    [
                        section1[idx[0]], 
                        section1[idx[1]], 
                        section1[idx[2]]
                    ], 
                    [
                        section2[idx[0]], 
                        section2[idx[1]], 
                        section2[idx[2]]
                    ]
                );
            }
        }
        
        for(i = [0:len(sections) - 2]) {
             two_sections(
                 sections[i], 
                 sections[i + 1]
             );
        }
    }
    
    if(triangles == "SOLID") {
        solid_sections(sections);
    } else if(triangles == "HOLLOW") {
        hollow_sections(sections);
    }
    else {
        triangles_defined_sections();
    }
}

// override it to test

module test_sweep_solid(points, faces, triangles) {

}