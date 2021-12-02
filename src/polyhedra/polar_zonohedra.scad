// http://archive.bridgesmathart.org/2021/bridges2021-7.pdf

// use <util/sum.scad>;
// use <util/flat.scad>;
// use <polyhedra/polar_zonohedra.scad>;

// for(n = [3:8]) {
//     translate([0.5 * n * (n - 3), 0, 0])
//         polar_zonohedra(n);
// }

use <geom_polar_zonohedra.scad>;

module polar_zonohedra(n, theta = 35.5) {
    points_faces = geom_polar_zonohedra(n, theta);
	polyhedron(points_faces[0], points_faces[1]);
}