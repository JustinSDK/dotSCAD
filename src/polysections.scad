/**
* polysections.scad
*
* Crosscutting a tube-like shape at different points gets several cross-sections.
* This module can operate reversely. It uses cross-sections to construct a tube-like shape.
* 
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-polysections.html
*
**/

module polysections(sections, triangles = "SOLID") {
    function side_indexes(sects, begin_idx = 0) = 
        let(       
            leng_sects = len(sects),
            leng_pts_sect = len(sects[0])
        ) 
        [
            for(j = [begin_idx:leng_pts_sect:begin_idx + (leng_sects - 2) * leng_pts_sect])
                for(i = [0:leng_pts_sect - 1]) 
                    [
                        j + i, 
                        j + (i + 1) % leng_pts_sect, 
                        j + (i + 1) % leng_pts_sect + leng_pts_sect , 
                        j + i + leng_pts_sect
                    ]
        ];

    module solid_sections(sects) {
        leng_pts_sect = len(sects[0]);
  
        first_idxes = [for(i = [0:leng_pts_sect - 1]) leng_pts_sect - 1 - i];  

        last_idxes = [
            for(i = [0:leng_pts_sect - 1]) 
                i + leng_pts_sect * (len(sects) - 1)
        ];    

        v_pts = [
            for(sect = sects) 
                for(pt = sect) 
                    pt
        ];
        
        polyhedron(
            v_pts, 
            concat([first_idxes], side_indexes(sects), [last_idxes])
        );    
    }

    module hollow_sections(sects) {
        leng_sects = len(sects);
        leng_sect = len(sects[0]);
        half_leng_sect = leng_sect / 2;
        half_leng_v_pts = leng_sects * half_leng_sect;

        function strip_sects(begin_idx, end_idx) = 
            [
                for(i = [0:leng_sects - 1]) 
                    [
                        for(j = [begin_idx:end_idx])
                            sects[i][j]
                    ]
            ]; 

        function end_idxes(begin_idx) = 
            [
                for(i =  [0:half_leng_sect - 1]) 
                    [
                        begin_idx + i, 
                        begin_idx + (i + 1) % half_leng_sect, 
                        begin_idx + (i + 1) % half_leng_sect + half_leng_v_pts, 
                        begin_idx + i + half_leng_v_pts
                    ]
            ];

        outer_sects = strip_sects(0, half_leng_sect - 1);
        inner_sects = strip_sects(half_leng_sect, leng_sect - 1);

        function to_v_pts(sects) = 
             [
                for(sect = sects) 
                    for(pt = sect) 
                        pt
             ];

        outer_v_pts =  to_v_pts(outer_sects);
        inner_v_pts = to_v_pts(inner_sects);

        outer_idxes = side_indexes(outer_sects);
        inner_idxes = side_indexes(inner_sects, half_leng_v_pts);
        first_idxes = end_idxes(0);
        last_idxes = end_idxes(half_leng_v_pts - half_leng_sect);

        polyhedron(
              concat(outer_v_pts, inner_v_pts),
              concat(first_idxes, outer_idxes, inner_idxes, last_idxes)
        ); 
    }
    
    module triangles_defined_sections() {
        module tri_sections(tri1, tri2) {
            polyhedron(
                points = concat(tri1, tri2),
                faces = [
                    [0, 1, 2], 
                    [3, 4, 5], 
                    [0, 1, 4], [1, 2, 5], [2, 0, 3], 
                    [0, 3, 4], [1, 4, 5], [2, 5, 3]
                ]
            );  
        }

        module two_sections(section1, section2) {
            for(idx = triangles) {
                // hull is for preventing from WARNING: Object may not be a valid 2-manifold
                hull() tri_sections(
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