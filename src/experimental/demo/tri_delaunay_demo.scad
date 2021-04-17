use <experimental/tri_delaunay.scad>;
use <hull_polyline2d.scad>;

points = [for(i = [0:20]) rands(-100, 100, 2)]; 

draw([for(ti = tri_delaunay(points)) [for(i = ti) points[i]]]);
%draw(tri_delaunay(points, ret = "TRI_SHAPES"));

module draw(pointsOfTriangles) {
	for(t = pointsOfTriangles) {
	    hull_polyline2d(concat(t, [t[0]]));
	}	
}