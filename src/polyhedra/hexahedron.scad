use <geom_hexahedron.scad>;

module hexahedron(radius, detail = 0) {
	points_faces = geom_hexahedron(radius, detail);
    polyhedron(points_faces[0], points_faces[1]);
} 