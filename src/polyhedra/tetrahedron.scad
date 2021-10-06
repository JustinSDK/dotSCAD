use <geom_tetrahedron.scad>;

module tetrahedron(radius, detail = 0, quick_mode = true) {
	points_faces = geom_tetrahedron(radius, detail, quick_mode);
    polyhedron(points_faces[0], points_faces[1]);
} 