/**
* path_scaling_sections.scad
*
* @copyright Justin Lin, 2019
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-path_scaling_sections.html
*
**/

use <util/reverse.scad>;
use <matrix/m_scaling.scad>;

function path_scaling_sections(shape_pts, edge_path) = 
    let(
        start_point = edge_path[0],
        base_leng = norm(start_point),
        scaling_matrice = [
            for(p = edge_path) 
            let(s = norm([p.x, p.y, 0]) / base_leng)
            m_scaling([s, s, 1])
        ],
        leng_edge_path = len(edge_path)
    )
    reverse([
        for(i = 0; i < leng_edge_path; i = i + 1)
        [
            for(p = shape_pts) 
            let(scaled_p = scaling_matrice[i] * [p.x, p.y, edge_path[i].z, 1])
            [scaled_p.x, scaled_p.y, scaled_p.z]
        ]
    ]);