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
use <../util/reverse.scad>;
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
			tri = reverse(triangles[i]), // OpenSCAD requires clockwise
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
        tri = cnn_tris[search([mid], points)[0]][0];
        nv = _face_normal([points[tri[0]], points[tri[1]], points[tri[2]]]);
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
                    _face_normal([
                        points[tri[0]], 
                        points[tri[1]], 
                        points[tri[2]]]
                    )
                ]
            )
            sum(normals) / len(normals)
        ];

        if(direction == "BOTH") {
            half_thickness = thickness / 2;
            pts1 = points + vertex_normals * half_thickness;
            pts2 = points - vertex_normals * half_thickness;
            sf_solidifyT(pts1, pts2, real_triangles, convexity = convexity);
        }
        else if(direction == "FORWARD") {
            pts1 = points + vertex_normals * thickness;
            pts2 = points;
            sf_solidifyT(pts1, pts2, real_triangles, convexity = convexity);
        }
        else {
            pts1 = points;
            pts2 = points - vertex_normals * thickness;
            sf_solidifyT(pts1, pts2, real_triangles, convexity = convexity);
        }
    }
}