/**
* path_scaling_sections.scad
*
* @copyright Justin Lin, 2019
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-path_scaling_sections.html
*
**/

function path_scaling_sections(shape_pts, edge_path) = 
    let(base_leng = norm(edge_path[0]))
    [
        for(i = [len(edge_path) - 1:-1:0])
        let(edge_p = edge_path[i], s = norm([edge_p.x, edge_p.y] / base_leng))
        [
            for(p = shape_pts * s) 
            [each p, edge_p.z]
        ]
    ];