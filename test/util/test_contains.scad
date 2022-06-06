use <voxel/vx_circle.scad>
use <util/contains.scad>

module test_contains() {
    echo("==== test_contains ====");

    pts = vx_circle(10);
    assert(contains(pts, [2, -10])); 
    assert(!contains(pts, [0, 0]));  
}

test_contains();