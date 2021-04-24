use <triangle/tri_delaunay.scad>;
use <triangle/tri_delaunay_shapes.scad>;
use <triangle/tri_delaunay_voronoi.scad>;
use <hull_polyline2d.scad>;

points = [for(i = [0:20]) rands(-100, 100, 2)]; 

color("black")
for(p = points) {
    translate(p)
	circle(2);
}

delaunay = tri_delaunay(points, ret = "DELAUNAY");

%draw(tri_delaunay_shapes(delaunay));
#draw(tri_delaunay_voronoi(delaunay));

module draw(pointsOfTriangles) {
	for(t = pointsOfTriangles) {
	    hull_polyline2d(concat(t, [t[0]]));
	}	
}