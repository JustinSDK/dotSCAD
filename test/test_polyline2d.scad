include <unittest.scad>;
include <line2d.scad>;

module test_polyline2d() { 

    $fn = 24;
    points = [[1, 2], [-5, -4], [-5, 3], [5, 5]];
    line_width = 1;
    leng_points = len(points);
            
    module assertCorrectSegment(index, point1, point2, width) {
        assertEqualPoint(points[index - 1], point1);
        assertEqualPoint(points[index], point2);
        assertEqualNum(line_width, width);    
    }
    
    module assertCorrectCaps(startStyle, endStyle, index, p1Style, p2Style) {
        function correctMiddleCaps(p1Style, p2Style) = 
                p1Style == "CAP_BUTT" && p2Style == "CAP_ROUND";    
    
        if(index == 1 && (p1Style != startStyle || p2Style != "CAP_ROUND")) {
            fail(
                "Wrong start caps", 
                str(
                    "expected: [", startStyle, ", \"CAP_ROUND\"]", 
                    ", but: ", [p1Style, p2Style]
                )
            );
        }
        
        if((1 < index && index < leng_points - 1) && !correctMiddleCaps(p1Style, p2Style)) {
            
            fail(
                "Wrong middle caps", 
                str(
                    "expected: [\"CAP_BUTT\", \"CAP_ROUND\"]", 
                    ", but: ", [p1Style, p2Style]
                )
            );
        }
        
        if(index == leng_points - 1 && (p1Style != "CAP_BUTT" || p2Style != endStyle)) {
            fail(
                "Wrong end caps",
                str(
                    "expected: [\"CAP_BUTT\, ", endStyle, "]", 
                    ", but: ", [p1Style, p2Style]
                )                    
            );
        }       
    }
            
    // testcases
    
    module test_polyline2d_cap_square() {
        echo("==== test_polyline2d_cap_square ====");
    
        include <polyline2d.scad>;
        
        module test_line_segment(index, point1, point2, width, p1Style, p2Style) {
        
            assertCorrectSegment(index, point1, point2, width);
            assertCorrectCaps(
                "CAP_SQUARE", "CAP_SQUARE", 
                index, p1Style, p2Style
            );
        } 
        
        polyline2d(points = points, width = line_width);
    }
    
    module test_polyline2d_cap_end_round() {
        echo("==== test_polyline2d_cap_end_round ====");
    
        include <polyline2d.scad>;
        
        module test_line_segment(index, point1, point2, width, p1Style, p2Style) {
        
            assertCorrectSegment(index, point1, point2, width);
            assertCorrectCaps(
                "CAP_SQUARE", "CAP_ROUND", 
                index, p1Style, p2Style
            );
        } 
        
        polyline2d(
            points = points, 
            width = line_width, 
            endingStyle = "CAP_ROUND"
        );
    }    
    
    module test_polyline2d_cap_round() {
        echo("==== test_polyline2d_cap_round ====");
    
        include <polyline2d.scad>;
        
        module test_line_segment(index, point1, point2, width, p1Style, p2Style) {
        
            assertCorrectSegment(index, point1, point2, width);
            assertCorrectCaps(
                "CAP_ROUND", "CAP_ROUND", 
                index, p1Style, p2Style
            );
        }  
        
        polyline2d(
            points = points, 
            width = line_width, 
            startingStyle = "CAP_ROUND", 
            endingStyle = "CAP_ROUND"
        );
    }    
    
    test_polyline2d_cap_square();
    test_polyline2d_cap_end_round();
    test_polyline2d_cap_round();
}

test_polyline2d();