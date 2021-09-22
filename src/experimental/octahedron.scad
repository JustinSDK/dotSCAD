use <experimental/geom_octahedron.scad>;

module octahedron(radius, detail = 0, quick_mode = true) {
	points_faces = geom_octahedron(radius, detail, quick_mode);
    polyhedron(points_faces[0], points_faces[1]);
} 