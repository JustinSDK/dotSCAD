/**
* path_scaling_sections.scad
*
* @copyright Justin Lin, 2019
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-path_scaling_sections.html
*
**/

include <__private__/__reverse.scad>;

function path_scaling_sections(shape_pts, edge_path) = 
    let(
        start_point = edge_path[0],
        base_leng = norm(start_point),
        scaling_matrice = [
            for(p = edge_path) 
            let(s = norm([p[0], p[1], 0]) / base_leng)
            m_scaling([s, s, 1])
        ]
    )
    [
        for(i = [0:len(edge_path) - 1])
        [
            for(p = __reverse(shape_pts)) 
            let(scaled_p = scaling_matrice[i] * [p[0], p[1], edge_path[i][2], 1])
            [scaled_p[0], scaled_p[1], scaled_p[2]]
        ]
    ];