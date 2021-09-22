use <experimental/geom_hexahedron.scad>;

module hexahedron(radius, detail = 0, quick_mode = true) {
	points_faces = geom_hexahedron(radius, detail, quick_mode);
    polyhedron(points_faces[0], points_faces[1]);
} 