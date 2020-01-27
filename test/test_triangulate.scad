use <unittest.scad>;    
use <triangulate.scad>; 

module test_triangulate() {
    echo("==== test_triangulate ====");


    shape = [
        [0, 0],
        [10, 0],
        [12, 5],
        [5, 10],
        [10, 15],
        [0, 20],
        [-5, 18],
        [-18, 3],
        [-4, 10]
    ];

    expected = [[8, 0, 1], [1, 2, 3], [3, 4, 5], [5, 6, 7], [8, 1, 3], [5, 7, 8], [8, 3, 5]];
    actual = triangulate(shape);

    assertEqualPoints(expected, actual);
}

test_triangulate();