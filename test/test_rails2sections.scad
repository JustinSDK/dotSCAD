use <unittest.scad>
use <bezier_curve.scad>
use <rails2sections.scad>

module test_rails2sections() {
    module test_simple_path() {

        echo("==== test_rails2sections_simple_path ====");

        paths = [
            [[5, 0, 5], [15, 10, 10], [25, 20, 5]],
            [[-5, 0, 5], [-15, 10, 10], [-25, 20, 5]],
            [[-5, 0, -5], [-15, 10, -10], [-25, 20, -5]],  
            [[5, 0, -5], [15, 10, -10], [25, 20, -5]]
        ];
        
        expected = [
            [[5, 0, 5], [-5, 0, 5], [-5, 0, -5], [5, 0, -5]],
            [[15, 10, 10], [-15, 10, 10], [-15, 10, -10], [15, 10, -10]],
            [[25, 20, 5], [-25, 20, 5], [-25, 20, -5], [25, 20, -5]]
        ];
        
        actual = rails2sections(paths);

        for(i = [0:len(paths[0]) - 1]) {
            assertEqualPoints(expected[i], actual[i]);
        }    
    }
    
     module test_bezier_path() {

        echo("==== test_rails2sections_bezier_path ====");

        t_step = 0.05;

        paths = [
            bezier_curve(t_step, 
                [[1.25, 0, 5], [5, 20, 5], [16, 20, -2], [18, 20, 10], [30, 15, 8]]
            ),
            bezier_curve(t_step, 
                [[-1.25, 0, 5], [0, 20, 5],  [16, 22, -2], [18, 20, 10], [30, 25, 8]]
            ),
            bezier_curve(t_step, 
                [[-1.25, 0, -5], [0, 20, -5], [16, 20, 1], [18, 27, -3], [20, 27, -5]]
            ),
            bezier_curve(t_step, 
                [[1.25, 0, -5], [5, 20, -5], [16, 20, 1], [18, 17.5, -3], [20, 17.5, -5]]
            )
        ];    
                        
        sections = rails2sections(paths);

        for(i = [0:len(sections) - 1]) {
            for(j = [0:len(sections[i]) - 1]) {
                assertEqualPoint(paths[j][i], sections[i][j]);
            }
        }
     }

    test_simple_path();
    test_bezier_path();
}

test_rails2sections();