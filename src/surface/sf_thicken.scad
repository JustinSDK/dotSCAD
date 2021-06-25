/**
* sf_thicken.scad
*
* @copyright Justin Lin, 2021
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-sf_thicken.html
*
**/ 

use <../util/sum.scad>;
use <sf_solidify.scad>;

module sf_thicken(points, thickness, direction = "BOTH") {
    function tri_normal(tri) =
        let(v = cross(tri[2] - tri[0], tri[1] - tri[0])) v / norm(v);    

    function vertex_normal(sf, xi, yi) = 
        let(
            xy = [xi, yi],
            // clockwise
            vi = [for(coord_offset = [[1, 0], [0, -1], [-1, 0], [0, 1]]) coord_offset + xy],
            normals = [
                for(i = [0:3])
                let(
                    vi0 = xy,
                    vi1 = vi[i],
                    vi2 = vi[(i + 1) % 4],
                    v0= sf[vi0[1]][vi0[0]], 
                    v1 = sf[vi1[1]][vi1[0]], 
                    v2 = sf[vi2[1]][vi2[0]]
                )
                if(!(is_undef(v0) || is_undef(v1) || is_undef(v2))) 
                    tri_normal([v0, v1, v2])
            ]
        )
        sum(normals) / len(normals);

    if(is_list(direction)) {
        dir_v = direction / norm(direction);
        surface_another = points + thickness * [
            for(y = [0:len(points) - 1])
            [
                for(x = [0:len(points[0]) - 1])
                    dir_v
            ]
        ];

        midy = len(points) / 2;
        midx = len(points[0]) / 2;
        nv = tri_normal([points[midy][midx], points[midy + 1][midx], points[midy][midx + 1]]);

        if(nv * dir_v > 0) {
            sf_solidify(surface_another, points);
        }
        else {
            sf_solidify(points, surface_another);
        }
    }
    else {
        vertex_normals = [
            for(y = [0:len(points) - 1])
            [
                for(x = [0:len(points[0]) - 1])
                    vertex_normal(points, x, y)
            ]
        ];        
        half_thickness = thickness / 2;
        if(direction == "BOTH") {
            surface_top = points + half_thickness * vertex_normals;
            surface_bottom = points - half_thickness * vertex_normals;    
            sf_solidify(surface_top, surface_bottom);
        }
        else if(direction == "FORWARD") {
            surface_top = points + thickness * vertex_normals;
            surface_bottom = points;    
            sf_solidify(surface_top, surface_bottom);
        }
        else {
            surface_top = points;
            surface_bottom = points - thickness * vertex_normals;    
            sf_solidify(surface_top, surface_bottom);
        }
    }
}

/*
use <surface/sf_thicken.scad>;

function f(x, y) = 
	30 * (
		cos(sqrt(pow(x, 2) + pow(y, 2))) + 
		cos(3 * sqrt(pow(x, 2) + pow(y, 2)))
	);

thickness = 3;
min_value =  -200;
max_value = 200;
resolution = 10;

surface1 = [
    for(y = [min_value:resolution:max_value])
        [
            for(x = [min_value:resolution:max_value]) 
                [x, y, f(x, y) + 100]
        ]
];
sf_thicken(surface1, thickness);
*/