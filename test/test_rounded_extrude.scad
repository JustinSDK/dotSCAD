include <unittest.scad>;

module test_rounded_extrude() {
    echo("==== test_rounded_extrude ====");

    include <rounded_extrude.scad>;
    
    expected_data = 
    [
        [],
        [20, 20, 0, 1.06526, 1.06526], 
        [21.3053, 21.3053, 0.0427757, 1.06022, 1.06022], 
        [22.5882, 22.5882, 0.170371, 1.05484, 1.05484], 
        [23.8268, 23.8268, 0.380602, 1.04924, 1.04924], 
        [25, 25, 0.669873, 1.0435, 1.0435], 
        [26.0876, 26.0876, 1.03323, 1.0377, 1.0377], 
        [27.0711, 27.0711, 1.46447, 1.03186, 1.03186], 
        [27.9335, 27.9335, 1.95619, 1.02602, 1.02602], 
        [28.6603, 28.6603, 2.5, 1.02019, 1.02019], 
        [29.2388, 29.2388, 3.08658, 1.01438, 1.01438], 
        [29.6593, 29.6593, 3.7059, 1.0086, 1.0086], 
        [29.9144, 29.9144, 4.34737, 1.00286, 1.00286]
    ];
    
    module test_rounded_extrude_data(i, wx, wy, pre_h, sx, sy) {
        data = [wx, wy, pre_h, sx, sy];
        
        for(j = [0:4]) {
            expected = round_n(expected_data[i][j]);
            actual = round_n(data[j]);
            assertEqual(expected, actual);
        }
    }

    $fn = 48;

    circle_r = 10;
    round_r = 5;

    rounded_extrude(circle_r * 2, round_r) 
        circle(circle_r);
}

test_rounded_extrude();


