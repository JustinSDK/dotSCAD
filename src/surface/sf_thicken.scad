/**
* sf_thicken.scad
*
* @copyright Justin Lin, 2021
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-sf_thicken.html
*
**/ 

use <../__comm__/_face_normal.scad>;
use <../util/sum.scad>;
use <sf_solidify.scad>;

module sf_thicken(points, thickness, direction = "BOTH", convexity = 1) {
    // clockwise
    dirs1 = [[1, 0], [0, -1], [-1, 0], [0, 1]];
    dirs2 = [[0, -1], [-1, 0], [0, 1], [1, 0]];
    function vertex_normal(sf, xi, yi) =    
        let(
            normals = [
                for(i = [0:3])
                let(
                    v0 = sf[yi][xi], 
                    dir1 = dirs1[i],
                    dir2 = dirs2[i],
                    v1 = sf[dir1.y + yi][dir1.x + xi], 
                    v2 = sf[dir2.y + yi][dir2.x + xi]
                )
                if(!(is_undef(v0) || is_undef(v1) || is_undef(v2))) 
                _face_normal([v0, v1, v2])
            ]
        )
        sum(normals) / len(normals);

    leng_points = len(points);
    leng_point0 = len(points[0]);
    if(is_list(direction)) {
        dir_v = direction / norm(direction);
        dir_vs = [for(x = [0:leng_point0 - 1]) dir_v];
        surface_another = points + thickness * [
            for(y = [0:leng_points - 1])
            dir_vs
        ];

        midy = leng_points / 2;
        midx = leng_point0 / 2;
        nv = _face_normal([points[midy][midx], points[midy + 1][midx], points[midy][midx + 1]]);

        if(nv * dir_v > 0) {
            sf_solidify(surface_another, points, convexity = convexity);
        }
        else {
            sf_solidify(points, surface_another, convexity = convexity);
        }
    }
    else {
        vertex_normals = [
            for(y = [0:leng_points - 1])
            [
                for(x = [0:leng_point0 - 1])
                    vertex_normal(points, x, y)
            ]
        ];        
        
        if(direction == "BOTH") {
            off = vertex_normals * (thickness / 2);
            sf_solidify(points + off, points - off, convexity = convexity);
        }
        else if(direction == "FORWARD") {
            sf_solidify(points + thickness * vertex_normals, points, convexity = convexity);
        }
        else {
            sf_solidify(points, points - thickness * vertex_normals, convexity = convexity);
        }
    }
}