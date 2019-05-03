/**
* path_extrude.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-path_extrude.html
*
**/

include <__private__/__is_vector.scad>;
include <__private__/__to3d.scad>;
include <__private__/__angy_angz.scad>;
include <__private__/__length_between.scad>;

module path_extrude(shape_pts, path_pts, triangles = "SOLID", twist = 0, scale = 1.0, closed = false) {
    function scale_pts(pts, s) = [
        for(p = pts) [p[0] * s[0], p[1] * s[1], p[2] * s[2]]
    ];
    
    function translate_pts(pts, t) = [
        for(p = pts) [p[0] + t[0], p[1] + t[1], p[2] + t[2]]
    ];
        
    function rotate_pts(pts, a, v) = [for(p = pts) rotate_p(p, a, v)];
    
    sh_pts = len(shape_pts[0]) == 3 ? shape_pts : [for(p = shape_pts) __to3d(p)];
    pth_pts = len(path_pts[0]) == 3 ? path_pts : [for(p = path_pts) __to3d(p)];
        
    len_path_pts = len(pth_pts);
    len_path_pts_minus_one = len_path_pts - 1;
    twist_step_a = twist / len_path_pts;

    function scale_step() =
        let(s =  (scale - 1) / len_path_pts_minus_one)
        [s, s, s];  

    scale_step_vt = __is_vector(scale) ? 
        [
            (scale[0] - 1) / len_path_pts_minus_one, 
            (scale[1] - 1) / len_path_pts_minus_one,
            scale[2] == undef ? 0 : (scale[2] - 1) / len_path_pts_minus_one
        ] : scale_step();         
    
    function init_section(a, s) =
        let(angleyz = __angy_angz(pth_pts[0], pth_pts[1]))
        rotate_pts(
            rotate_pts(
                rotate_pts(
                    scale_pts(sh_pts, s), a
                ), [90, 0, -90]
            ), [0, -angleyz[0], angleyz[1]]
        );
        
    function local_rotate_section(j, init_a, init_s) =
        j == 0 ? 
            init_section(init_a, init_s) : 
            local_rotate_section_sub(j, init_a, init_s);
    
    function local_rotate_section_sub(j, init_a, init_s) = 
        let(
            vt0 = pth_pts[j] - pth_pts[j - 1],
            vt1 = pth_pts[j + 1] - pth_pts[j],
            a = acos((vt0 * vt1) / (norm(vt0) * norm(vt1))),
            v = cross(vt0, vt1)
        )
        rotate_pts(
            local_rotate_section(j - 1, init_a, init_s),
            a,
            v
        );

    function sections() =
        let(
            fst_section = 
                translate_pts(local_rotate_section(0, 0, [1, 1, 1]), pth_pts[0]),
            remain_sections = [
                for(i = [0:len_path_pts - 2]) 
                
                    translate_pts(
                        local_rotate_section(i, i * twist_step_a, [1, 1, 1] + scale_step_vt * i),
                        pth_pts[i + 1]
                    )
                
                    
            ]
        ) concat([fst_section], remain_sections);
    
    sects = sections();

    function calculated_sections() =
        closed && pth_pts[0] == pth_pts[len_path_pts - 1] ?
            concat(sects, [sects[0]]) : // round-robin
            sects;
     
     polysections(
        calculated_sections(),
        triangles = triangles
    );   

    // hook for testing
    test_path_extrude(sects);
}


// override to test
module test_path_extrude(sections) {

}