use <../util/sort.scad>;
use <../util/find_index.scad>;
use <../util/slice.scad>;
use <../util/sum.scad>;
use <../surface/sf_solidify_tri.scad>;

module sf_thicken_tri(points, thickness, triangles = undef, direction = "BOTH") {
    // triangles : counter-clockwise
    tris = [for(tri = triangles) [tri[2], tri[1], tri[0]]];

	ascending = function(e1, e2) e1 - e2;

	function connected_tris(leng_pts, triangles) =
		let(
			leng = len(triangles),
			cnt_tris = [for(i = [0:leng_pts - 1]) []]
		)
		_connected_tris(triangles, leng, cnt_tris);
		
	function _connected_tris(triangles, leng, cnt_tris, i = 0) = 
		i == leng ? cnt_tris :
		let(
			tri = sort(triangles[i], by = ascending),
			b0 = cnt_tris[tri[0]],
			b1 = cnt_tris[tri[1]],
			b2 = cnt_tris[tri[2]],
			nb0 = concat(b0, [triangles[i]]),
			nb1 = concat(b1, [triangles[i]]),
			nb2 = concat(b2, [triangles[i]]),
			n_cnt_tris = concat(
				slice(cnt_tris, 0, tri[0]),
				[nb0],
				slice(cnt_tris, tri[0] + 1, tri[1]),
				[nb1],
				slice(cnt_tris, tri[1] + 1, tri[2]),
				[nb2],
				slice(cnt_tris, tri[2] + 1)
			)
		)
		_connected_tris(triangles, leng, n_cnt_tris, i + 1);

	function tri_normal(tri) =
		let(v = cross(tri[2] - tri[0], tri[1] - tri[0])) v / norm(v); 

    leng_pts = len(points);
    cnn_tris = connected_tris(leng_pts, tris);

    if(is_list(direction)) {
        dir_v = direction / norm(direction);
        mid = sort(points)[leng_pts / 2];
        tri = cnn_tris[find_index(points, function(p) p == mid)][0];
        nv = tri_normal([points[tri[0]], points[tri[1]], points[tri[2]]]);
        pts = [for(p = points) p + dir_v * thickness];

        if(nv * dir_v > 0) {
            sf_solidify_tri(pts, points, triangles);
        }
        else {
            sf_solidify_tri(points, pts, triangles);
        }
    }
    else {
        vertex_normals = [
            for(i = [0:leng_pts - 1])
            let(
                normals = [
                    for(tri = cnn_tris[i])
                    tri_normal([
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
            sf_solidify_tri(pts1, pts2, triangles);
        }
        else if(direction == "FORWARD") {
            pts1 = points + vertex_normals * thickness;
            pts2 = points;
            sf_solidify_tri(pts1, pts2, triangles);
        }
        else {
            pts1 = points;
            pts2 = points - vertex_normals * thickness;
            sf_solidify_tri(pts1, pts2, triangles);
        }
    }
}

/*

use <triangle/tri_delaunay.scad>;
use <triangle/tri_delaunay_indices.scad>;
use <triangle/tri_delaunay_shapes.scad>;

use <surface/sf_thicken_tri.scad>;

points = [for(i = [0:50]) rands(-200, 200, 2)]; 

delaunay = tri_delaunay(points, ret = "DELAUNAY");

indices = tri_delaunay_indices(delaunay);
shapes = tri_delaunay_shapes(delaunay);

for(tri = shapes) {
    offset(-1)
        polygon(tri);
}

pts = [for(p = points) [p[0], p[1], rands(100, 120, 1)[0]]];
thickness = 5;

sf_thicken_tri(pts, thickness, indices);




*/