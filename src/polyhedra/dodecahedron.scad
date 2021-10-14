use <geom_dodecahedron.scad>;

module dodecahedron(radius, detail = 0) {
	points_faces = geom_dodecahedron(radius, detail);
    polyhedron(points_faces[0], points_faces[1]);
} 
