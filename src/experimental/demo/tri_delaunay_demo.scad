use <hull_polyline2d.scad>;
use <experimental/tri_delaunay.scad>;
   
points=[for(i = [0:50]) rands(-20, 20, 2)];

for(tri = tri_delaunay(points)) {
    hull_polyline2d(
        [points[tri[0]], points[tri[1]], points[tri[2]], points[tri[0]]], width = .2
    );
}

color("red")
for(point = points) {
   translate(point) 
       circle(.5);
}