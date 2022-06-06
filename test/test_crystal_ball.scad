use <unittest.scad>
include <crystal_ball.scad>

module test_crystal_ball_pie(shape_pts) {
    expected = [[0, 0], [5.1392, 2.9671], [4.8541, 3.5267], [3.5267, 4.8541], [2.9671, 5.1392]];
    assertEqualPoints(expected, shape_pts);
}

module test_theta_phi() {
    echo("==== test_crystal_ball_theta_phi ====");
        
    crystal_ball( 
        radius = 6, 
        theta = [-30, 270],
        phi = [30, 60]
    );  
}     

test_theta_phi();

