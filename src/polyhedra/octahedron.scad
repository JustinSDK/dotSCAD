use <geom_octahedron.scad>;

module octahedron(radius, detail = 0) {
	points_faces = geom_octahedron(radius, detail);
    polyhedron(points_faces[0], points_faces[1]);
} 