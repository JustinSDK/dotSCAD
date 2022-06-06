use <voxel/vx_ascii.scad>
use <voxel/vx_contour.scad>

module test_vx_contour() {
    echo("==== test_vx_contour ====");

    expected = [[0, 1], [1, 1], [1, 0], [2, 0], [3, 0], [4, 0], [5, 0], [6, 0], [7, 0], [7, 1], [7, 2], [7, 3], [7, 4], [7, 5], [7, 6], [7, 7], [6, 7], [5, 7], [4, 7], [4, 6], [4, 5], [3, 5], [2, 5], [1, 5], [1, 4], [0, 4], [0, 3], [0, 2]];
    actual = vx_contour(vx_ascii("d"));

    assert(expected == actual);
}

test_vx_contour();