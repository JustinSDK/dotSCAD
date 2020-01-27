use <unittest.scad>;
use <line3d.scad>;

module test_line3d() {
    p1 = [0, 0, 0];
    p2 = [10, 2, 10];
    thickness = 1;
    fn = 24;

    echo("==== test_line3d_default_caps ====");
    
    module test_line3d_butt(p, r, frags, length, angles) {
        assertEqualPoint(p1, p);
        assertEqualNum(thickness / 2, r);
        assertEqualNum(fn, frags);
        assertEqualNum(14.2829, length);
        assertEqualPoint([0, 45.5618, 11.3099], angles);
    }

    module test_line3d_cap(p, r, frags, cap_leng, angles) {
        assert(p == p1 || p == p2);
        assertEqualNum(thickness / 2, r);
        assertEqualNum(fn, frags); 
        assertEqualNum(0.3536, cap_leng);
        assertEqualPoint([0, 45.5618, 11.3099], angles);
    }        
            
    
    line3d(
        p1 = p1, 
        p2 = p2, 
        thickness = thickness,
        $fn = fn
    );       
}

test_line3d();