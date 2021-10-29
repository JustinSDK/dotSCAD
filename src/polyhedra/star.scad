use <geom_star.scad>;

module star(outerRadius = 1, innerRadius =  0.381966, height = 0.5, n = 5) {
    points_faces = star(outerRadius, innerRadius, height, n);
    polyhedron(points_faces[0], points_faces[1]);
}