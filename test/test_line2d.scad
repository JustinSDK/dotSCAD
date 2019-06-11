include <unittest.scad>;

module test_line2d() {
    $fn = 24;
    p1 = [0, 0];
    p2 = [5, 0];
    width = 1;    

    module test_line2d_cap_square() {
        echo("==== test_line2d_cap_square ====");
        
        include <line2d.scad>;
        
        module test_line2d_cap(point, style) {
            assert(
                (point == p1 && style == "CAP_SQUARE") ||
                (point == p2 && style == "CAP_SQUARE")
            );
        }
        
        module test_line2d_line(angle, length, width, frags) {
            assertEqual(0, angle);
            assertEqual(5, length);
            assertEqual(1, width);
            assertEqual(24, frags);
        }     
        
        line2d(p1 = p1, p2 = p2, width = width); 
    }

    module test_line2d_cap_round() {
        echo("==== test_line2d_cap_round ====");

        include <line2d.scad>;
        
        module test_line2d_cap(point, style) {
            assert(
                (point == p1 && style == "CAP_ROUND") ||
                (point == p2 && style == "CAP_ROUND")
            );
        }    
        
        module test_line2d_line(angle, length, width, frags) {
            assertEqual(0, angle);
            assertEqual(5, length);
            assertEqual(1, width);
            assertEqual(24, frags);
        }     
        
        line2d(p1 = p1, p2 = p2, width = width, 
            p1Style = "CAP_ROUND", p2Style = "CAP_ROUND");
    }

    module test_line2d_cap_butt() {
        echo("==== test_line2d_cap_butt ====");
            
        include <line2d.scad>;
        
        module test_line2d_cap(point, style) {
            assert(
                (point == p1 && style == "CAP_BUTT") ||
                (point == p2 && style == "CAP_BUTT")
            );
        }    
        
        module test_line2d_line(angle, length, width, frags) {
            assertEqual(0, angle);
            assertEqual(5, length);
            assertEqual(1, width);
            assertEqual(24, frags);
        }     
        
        line2d(p1 = p1, p2 = p2, width = width, 
            p1Style = "CAP_BUTT", p2Style = "CAP_BUTT");
    }

    test_line2d_cap_square();
    test_line2d_cap_round();
    test_line2d_cap_butt();    
}

test_line2d();

