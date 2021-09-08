use <experimental/geom_icosahedron.scad>;

module icosahedron(radius, detail = 0, quick_mode = true) {
	points_faces = geom_icosahedron(radius, detail, quick_mode);
    polyhedron(points_faces[0], points_faces[1]);
} 