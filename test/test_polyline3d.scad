use <unittest.scad>;
use <polyline3d.scad>;

module test_polyline3d() { 
    $fn = 24;
    
    points =  [
        [1, 2, 1], 
        [-5, -4, 2], 
        [-5, 3, 3], 
        [5, 5, 4]
    ];
    line_thickness = 1;
    leng_points = len(points);
            
    module assertCorrectSegment(expected, actual, thickness) {
        assertEqualPoint(expected[0], actual[0]);
        assertEqualPoint(expected[1], actual[1]);
        assertEqualNum(line_thickness, thickness);    
    }
    
    module assertCorrectCaps(leng_pts, startStyle, endStyle, index, p1Style, p2Style) {
        function correctMiddleCaps(p1Style, p2Style) = 
                p1Style == "CAP_SPHERE" && p2Style == "CAP_BUTT";    
    
        if(index == 1 && (p1Style != startStyle || p2Style != "CAP_BUTT")) {
            fail(
                "Wrong start caps", 
                str(
                    "expected: [", startStyle, ", \"CAP_BUTT\"]", 
                    ", but: ", [p1Style, p2Style]
                )
            );
        }
        
        if((1 < index && index < leng_pts - 1) && !correctMiddleCaps(p1Style, p2Style)) {
            
            fail(
                "Wrong middle caps", 
                str(
                    "expected: [\"CAP_SPHERE\", \"CAP_BUTT\"]", 
                    ", but: ", [p1Style, p2Style]
                )
            );
        }
        
        if(index == leng_pts - 1 && (p1Style != "CAP_SPHERE" || p2Style != endStyle)) {
            fail(
                "Wrong end caps",
                str(
                    "expected: [\"CAP_SPHERE\, ", endStyle, "]", 
                    ", but: ", [p1Style, p2Style]
                )                    
            );
        }       
    }
            
    // testcases
    
    module test_polyline3d_cap_default() {
        echo("==== test_polyline3d_cap_default ====");
    
        module test_polyline3d_line3d_segment(index, point1, point2, thickness, p1Style, p2Style) {
        
            assertCorrectSegment(
                [points[index - 1], points[index]],
                [point1, point2], 
                thickness
            );
            assertCorrectCaps(
                leng_points,
                "CAP_CIRCLE", "CAP_CIRCLE", 
                index, p1Style, p2Style
            );
        } 
        
        polyline3d(
            points = points, 
            thickness = line_thickness,
            $fn = 24
        ); 
    }
    
    test_polyline3d_cap_default();
}

test_polyline3d();