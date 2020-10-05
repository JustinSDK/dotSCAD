use <../__comm__/_convex_hull3.scad>;

module polyhedron_hull(points) {
    vts_faces = _convex_hull3(points);
    polyhedron(vts_faces[0], vts_faces[1]);
}