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

include <__private__/__triangles_radial.scad>;
include <__private__/__triangles_tape.scad>; 

module polysections(sections, triangles = "RADIAL") {
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
    
    function flat(vector, i = 0) =
        i == len(vector) ? [] :
        concat(vector[i], flat(vector, i + 1));    
    
    function hollow_tris() = 
        let(
            leng_section = len(sections[0]),
            inner_i_begin = leng_section / 2,
            pair_idxes = [for(i = [0:inner_i_begin - 1])
                let(n = inner_i_begin + i + 1)
                [
                    [i, inner_i_begin + i, n % inner_i_begin + inner_i_begin], 
                    [i, i + 1, n % leng_section]
                ]
                
            ]
           
        ) flat(pair_idxes); 

    function tris() = triangles == "RADIAL" ? __triangles_radial(sections[0]) : 
        (
            triangles == "HOLLOW" ? hollow_tris() : (
                triangles == "TAPE" ? __triangles_tape(sections[0]) : triangles 
            )
        );

    module two_sections(section1, section2) {
        for(idx = tris()) {
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