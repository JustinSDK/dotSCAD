use <experimental/tri_delaunay.scad>;
use <hull_polyline2d.scad>;

points = [for(i = [0:20]) rands(-100, 100, 2)]; 

drawTris(tri_delaunay(points));
module drawTris(pointsOfTriangles) {
	#for(t = pointsOfTriangles) {
	    hull_polyline2d(concat(t, [t[0]]));
	}	
}

drawTris2(points, tri_delaunay(points, ret = "INDICES"));
module drawTris2(points, indices) {
    pointsOfTriangles = [for(i = indices) [points[i[0]], points[i[1]], points[i[2]]]];
	%for(t = pointsOfTriangles) {
	    hull_polyline2d(concat(t, [t[0]]), 2);
	}	
}
