/**
* rail_extruded_sections.scad
*
* @copyright Justin Lin, 2019
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-rail_extruded_sections.html
*
**/

use <util/reverse.scad>;
use <matrix/m_scaling.scad>;

function rail_extruded_sections(shape_pts, rail) = 
    let(
        start_point = rail[0],
        base_leng = norm(start_point),
        scaling_matrice = [
            for(p = rail) 
            let(s = norm([p[0], p[1], 0]) / base_leng)
            m_scaling([s, s, 1])
        ],
        leng_rail = len(rail)
    )
    reverse([
        for(i = 0; i < leng_rail; i = i + 1)
        [
            for(p = shape_pts) 
            let(scaled_p = scaling_matrice[i] * [p[0], p[1], rail[i][2], 1])
            [scaled_p[0], scaled_p[1], scaled_p[2]]
        ]
    ]);