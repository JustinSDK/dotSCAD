/**
* path_extend.scad
*
* It extends a 2D stroke along a path. 
* This module is suitable for a path created by a continuous function.
* It depends on the rotate_p function and the polytransversals module. 
* Remember to include "rotate_p.scad" and "polytransversals.scad".
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-path_extend.html
*
**/

module path_extend(stroke_pts, path_pts, scale = 1.0, round_robin = false) {
    function length(p1, p2) = 
        let(
            x1 = p1[0],
            y1 = p1[1],
            x2 = p2[0],
            y2 = p2[1]
        ) sqrt(pow(x2 - x1, 2) + pow(y2 - y1, 2));

    function az(p1, p2) = 
        let(
            x1 = p1[0],
            y1 = p1[1],
            x2 = p2[0],
            y2 = p2[1]
        ) -90 + atan2((y2 - y1), (x2 - x1));
    
    leng_path_pts = len(path_pts);

    scale_step = (scale - 1) / (leng_path_pts - 1);

    echo(scale_step);

    function first_stroke() =
        let(
            p1 = path_pts[0],
            p2 = path_pts[1],
            a = az(p1, p2)
        )
        [
            for(p = stroke_pts)
                rotate_p(p, a) + p1
        ];    
    
    function stroke(p1, p2, i) =
        let(
            leng = length(p1, p2),
            a = az(p1, p2)
        )
        [
            for(p = stroke_pts)
                rotate_p(p * (1 + scale_step * i) + [0, leng], a) + p1
        ];
        
    function path_extend_inner(index) =
        index == leng_path_pts ? [] :
            concat(
               [stroke(path_pts[index - 1], path_pts[index], index)],
               path_extend_inner(index + 1)
           );
    if(round_robin && path_pts[0] == path_pts[leng_path_pts - 1]) {

    } else {
        polytransversals(
            concat([first_stroke()], path_extend_inner(1))
        );
    }
}
