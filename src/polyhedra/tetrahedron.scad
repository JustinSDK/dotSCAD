use <geom_tetrahedron.scad>;

module tetrahedron(radius, detail = 0) {
	points_faces = geom_tetrahedron(radius, detail);
    polyhedron(points_faces[0], points_faces[1]);
} 