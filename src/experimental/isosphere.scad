use <experimental/geom_isosphere.scad>;

module isosphere(radius, detail = 0) {
	points_faces = geom_isosphere(radius, detail);
    polyhedron(points_faces[0], points_faces[1]);
} 