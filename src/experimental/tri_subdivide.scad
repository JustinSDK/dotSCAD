function _tri_subdivide(points) =
     let(
	     p0 = points[0],
		 p1 = points[1],
		 p2 = points[2],
		 m0 = (p0 + p1) / 2,
		 m1 = (p1 + p2) / 2,
		 m2 = (p2 + p0) / 2
	 )
	 [
	     [p0, m0, m2],
		 [m0, p1, m1],
		 [m1, p2, m2],
		 [m0, m1, m2]
	 ]; 

function tri_subdivide(points, n = 1) =
    n == 1 ? _tri_subdivide(points) :
	[for(tri = tri_subdivide(points, n - 1)) each _tri_subdivide(tri)];