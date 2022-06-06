/**
* sf_thickenT.scad
*
* @copyright Justin Lin, 2021
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-sf_thickenT.html
*
**/ 

use <../__comm__/__to2d.scad>
use <../__comm__/_face_normal.scad>
use <../util/sorted.scad>
use <../util/sum.scad>
use <../util/contains.scad>
use <../util/unit_vector.scad>
use <../surface/sf_solidifyT.scad>
use <../triangle/tri_delaunay.scad>

module sf_thickenT(points, thickness, triangles = undef, direction = "BOTH", convexity = 1) {
    // triangles : counter-clockwise
    real_triangles = is_undef(triangles) ? tri_delaunay([for(p = points) __to2d(p)]) : triangles;

    leng_pts = len(points);
    conn_indices_tris = [for(tri = real_triangles, i = tri) [i, tri]];

    if(is_list(direction)) {
        dir_v = unit_vector(direction);

        mid_pt = sorted(points)[leng_pts / 2];
        mid_i = search([mid_pt], points)[0];
        indices = search(mid_i, conn_indices_tris, num_returns_per_match = 0);
        nvs = [
            for(j = indices) 
            let(tri = conn_indices_tris[j][1])
            _face_normal([for(i = [2, 1, 0]) points[tri[i]]]) // OpenSCAD requires clockwise
        ]; 
        nv = sum(nvs) / len(nvs);   
        
        off = dir_v * thickness;
        pts = [for(p = points) p + off];

        if(nv * dir_v > 0) {
            sf_solidifyT(pts, points, real_triangles, convexity = convexity);
        }
        else {
            sf_solidifyT(points, pts, real_triangles, convexity = convexity);
        }
    }
    else {
        vertex_normals = [
            for(i = [0:leng_pts - 1])
            let(
                indices = search(i, conn_indices_tris, num_returns_per_match = 0),
                face_normals = [ 
                    for(j = indices)
                    let(tri = conn_indices_tris[j][1])
                    _face_normal([for(k = [2, 1, 0]) points[tri[k]]]) // OpenSCAD requires clockwise
                ]
            )
            sum(face_normals) / len(face_normals)
        ];

        if(direction == "BOTH") {
            off = vertex_normals * (thickness / 2);
            sf_solidifyT(points + off, points - off, real_triangles, convexity = convexity);
        }
        else if(direction == "FORWARD") {
            sf_solidifyT(points + vertex_normals * thickness, points, real_triangles, convexity = convexity);
        }
        else {
            sf_solidifyT(points, points - vertex_normals * thickness, real_triangles, convexity = convexity);
        }
    }
}