/**
* sf_thickenT.scad
*
* @copyright Justin Lin, 2021
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-sf_thickenT.html
*
**/ 

use <../__comm__/__to2d.scad>;
use <../__comm__/_face_normal.scad>;
use <../util/sorted.scad>;
use <../util/sum.scad>;
use <../util/contains.scad>;
use <../surface/sf_solidifyT.scad>;
use <../triangle/tri_delaunay.scad>;

module sf_thickenT(points, thickness, triangles = undef, direction = "BOTH", convexity = 1) {
    // triangles : counter-clockwise
    real_triangles = is_undef(triangles) ? tri_delaunay([for(p = points) __to2d(p)]) : triangles;

	function connected_tris(leng_pts, triangles) =
		let(leng = len(triangles))
		_connected_tris(triangles, leng, leng_pts, []);
		
	function _connected_tris(triangles, leng, leng_pts, cnt_tris, i = 0) = 
		i == leng ? cnt_tris :
		let(
			tri = triangles[i], 
            n_cnt_tris = [
                for(k = [0:leng_pts - 1])
                contains(tri, k) ? [each cnt_tris[k], tri] : cnt_tris[k]
            ]
		)
		_connected_tris(triangles, leng, leng_pts, n_cnt_tris, i + 1);

    leng_pts = len(points);
    cnn_tris = connected_tris(leng_pts, real_triangles);

    if(is_list(direction)) {
        dir_v = direction / norm(direction);
        mid = sorted(points)[leng_pts / 2];
        tris = cnn_tris[search([mid], points)[0]];
        nvs = [for(tri = tris) _face_normal([for(i = [2, 1, 0]) points[tri[i]]])]; // OpenSCAD requires clockwise
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
                normals = [
                    for(tri = cnn_tris[i])
                    _face_normal([for(j = [2, 1, 0]) points[tri[j]]]) // OpenSCAD requires clockwise
                ]
            )
            sum(normals) / len(normals)
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