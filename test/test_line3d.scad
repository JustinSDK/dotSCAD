use <unittest.scad>
include <line3d.scad>

module test_line3d_butt(p, r, frags, length, angles) {
    p1 = [0, 0, 0];
    p2 = [10, 2, 10];
    diameter = 1;
    fn = 24;
    assertEqualPoint(p1, p);
    assertEqualNum(diameter / 2, r);
    assertEqualNum(fn, frags);
    assertEqualNum(14.2829, length);
    assertEqualPoint([0, 45.5618, 11.3099], angles);
}

module test_line3d_cap(p, r, frags, cap_leng, angles) {
    p1 = [0, 0, 0];
    p2 = [10, 2, 10];
    diameter = 1;
    fn = 24;
    assert(p == p1 || p == p2);
    assertEqualNum(diameter / 2, r);
    assertEqualNum(fn, frags); 
    assertEqualNum(0.3536, cap_leng);
    assertEqualPoint([0, 45.5618, 11.3099], angles);
} 
 
module test_line3d() {
    p1 = [0, 0, 0];
    p2 = [10, 2, 10];
    diameter = 1;
    fn = 24;

    echo("==== test_line3d_default_caps ====");      
    
    line3d(
        p1 = p1, 
        p2 = p2, 
        diameter = diameter,
        $fn = fn
    );       
}

test_line3d();