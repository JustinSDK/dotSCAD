/**
* sf_thickenT.scad
*
* @copyright Justin Lin, 2021
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-sf_thickenT.html
*
**/ 

use <../__comm__/_face_normal.scad>;
use <../util/sort.scad>;
use <../util/find_index.scad>;
use <../util/sum.scad>;
use <../surface/sf_solidifyT.scad>;
use <../triangle/tri_delaunay.scad>;

module sf_thickenT(points, thickness, triangles = undef, direction = "BOTH", convexity = 1) {
    // triangles : counter-clockwise
    real_triangles = is_undef(triangles) ? tri_delaunay([for(p = points) [p[0], p[1]]]) : triangles;

    tris = [for(tri = real_triangles) [tri[2], tri[1], tri[0]]];

	ascending = function(e1, e2) e1 - e2;

	function connected_tris(leng_pts, triangles) =
		let(
			leng = len(triangles),
			cnt_tris = [for(i = [0:leng_pts - 1]) []]
		)
		_connected_tris(triangles, leng, leng_pts, cnt_tris);
		
	function _connected_tris(triangles, leng, leng_pts, cnt_tris, i = 0) = 
		i == leng ? cnt_tris :
		let(
			tri = sort(triangles[i], by = ascending),
            n_cnt_tris = [
                for(k = [0:leng_pts - 1])
                find_index(tri, function(e) e == k) != -1 ? [each cnt_tris[k], triangles[i]] : cnt_tris[k]
            ]
		)
		_connected_tris(triangles, leng, leng_pts, n_cnt_tris, i + 1);

    leng_pts = len(points);
    cnn_tris = connected_tris(leng_pts, tris);

    if(is_list(direction)) {
        dir_v = direction / norm(direction);
        mid = sort(points)[leng_pts / 2];
        tri = cnn_tris[find_index(points, function(p) p == mid)][0];
        nv = _face_normal([points[tri[0]], points[tri[1]], points[tri[2]]]);
        pts = [for(p = points) p + dir_v * thickness];

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