/**
* starburst.scad
*
* @copyright Justin Lin, 2019
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-starburst.html
*
**/

module starburst(r1, r2, n, height) {
    echo("`starburst` is deprecated since 3.2. Use `polyhedra/star` instead.");

    a = 180 / n;

    p0 = [0, 0, 0];
    p1 = [r2 * cos(a), r2 * sin(a), 0];
    p2 = [r1, 0, 0];
    p3 = [0, 0, height];

    module half_burst() {
        polyhedron(points = [p0, p1, p2, p3], 
            faces = [
                [0, 2, 1],
                [0, 1, 3],
                [0, 3, 2], 
                [2, 1, 3]
            ]
        );
    }

    module burst() {
        hull() {
            half_burst();
            mirror([0, 1, 0]) half_burst();
        }
    }

    for(i = [0 : n - 1]) {
        rotate(2 * a * i) burst();
    }    
}