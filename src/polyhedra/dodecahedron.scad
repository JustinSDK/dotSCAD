use <geom_dodecahedron.scad>;

module dodecahedron(radius, detail = 0, quick_mode = true) {
	points_faces = geom_dodecahedron(radius, detail, quick_mode);
    polyhedron(points_faces[0], points_faces[1]);
} 
