module polysections(sections, triangles = "RADIAL") {
    module tri_sections(tri1, tri2) {
        polyhedron(
            points = concat(tri1, tri2),
            faces = concat(
                [[0, 1, 2]],
                [[3, 4, 5]],
                [for(i = [0:2]) [i, (i + 1) % 3, (i + 1) % 3 + 3]],
                [for(i = [0:2]) [i, i % 3 + 3, (i + 1) % 3 + 3]]
            )
        );  
    }
    
    function flat(vector, i = 0) =
        i == len(vector) ? [] :
        concat(vector[i], flat(vector, i + 1));    
    
    leng_section = len(sections[0]);
    
    function radial_tris() = [
        for(i = [1:leng_section - 2]) [0, i, i + 1]
    ];
        
    function hollow_tris() = 
        let(
            inner_i_begin = leng_section / 2,
            pair_idxes = [for(i = [0:inner_i_begin - 1])
                let(n = inner_i_begin + i + 1)
                [
                    [i, inner_i_begin + i, n % inner_i_begin + inner_i_begin], 
                    [i, i + 1, n % leng_section]
                ]
                
            ]
           
        ) flat(pair_idxes); 

    function tris() = triangles == "RADIAL" ? radial_tris() : 
        (triangles == "HOLLOW" ? hollow_tris() : triangles);
    
    module two_sections(section1, section2) {
        for(idx = tris()) {
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