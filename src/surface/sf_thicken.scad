/**
* sf_thicken.scad
*
* @copyright Justin Lin, 2021
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-sf_thicken.html
*
**/ 

use <../__comm__/_face_normal.scad>
use <../util/sum.scad>
use <../util/unit_vector.scad>
use <sf_solidify.scad>

module sf_thicken(points, thickness, direction = "BOTH", convexity = 1) {
    // clockwise
    dirs = [
        [[ 1,  0], [ 0, -1]],
        [[ 0, -1], [-1,  0]],
        [[-1,  0], [ 0,  1]],
        [[ 0,  1], [ 1,  0]]
    ];
    function vertex_normal_xs(sf, x_range, yi) = 
        let(sfyi = sf[yi])
        [
            for(xi = x_range) 
            let(v0 = sfyi[xi])
            if(!is_undef(v0))
                let(
                    xyi = [xi, yi],
                    normals = [
                        for(dir = dirs)
                        let(
                            p1 = dir[0] + xyi,
                            v1 = sf[p1.y][p1.x], 
                            p2 = dir[1] + xyi,
                            v2 = sf[p2.y][p2.x]
                        )
                        if(!(is_undef(v1) || is_undef(v2))) 
                        _face_normal([v0, v1, v2])
                    ]
                )
                sum(normals) / len(normals)
        ];

    leng_points = len(points);
    leng_point0 = len(points[0]);
    x_range = [0:leng_point0 - 1];
    if(is_list(direction)) {
        dir_v = unit_vector(direction);
        dir_vs = [for(x = x_range) dir_v];
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
            vertex_normal_xs(points, x_range, y)
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