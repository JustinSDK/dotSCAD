use <experimental/geom_icosahedron.scad>;

module icosahedron(radius, detail = 0) {
	points_faces = geom_icosahedron(radius, detail);
    polyhedron(points_faces[0], points_faces[1]);
} 