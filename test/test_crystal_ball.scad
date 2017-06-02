include <unittest.scad>;

include <rotate_p.scad>;
include <cross_sections.scad>;
include <polysections.scad>;
include <ring_extrude.scad>;
include <shape_pie.scad>;

module test_crystal_ball() {
    module test_a_ball() {
        echo("==== test_crystal_ball_a_ball ====");
        
        include <crystal_ball.scad>;
        
        module test_crystal_ball_pie(shape_pts) {

            expected = [[0, 0], [0, -6], [1.8541, -5.7063], [3.5267, -4.8541], [4.8541, -3.5267], [5.7063, -1.8541], [6, 0], [5.7063, 1.8541], [4.8541, 3.5267], [3.5267, 4.8541], [1.8541, 5.7063], [0, 6]];
            
            assertEqualPoints(expected, shape_pts);
        }
        
        crystal_ball(radius = 6);
    }
    
    module test_theta() {
        echo("==== test_crystal_ball_theta ====");
        
        include <crystal_ball.scad>;
        
        module test_crystal_ball_pie(shape_pts) {
          
            expected = [[0, 0], [0, -6], [3, -5.1962], [5.1962, -3], [6, 0], [5.1962, 3], [3, 5.1962], [0, 6]];
            
            assertEqualPoints(expected, shape_pts);
        }
            
        crystal_ball(
            radius = 6, 
            theta = 270,
            $fn = 12
        );
    }    
    
    module test_phi() {
        
        include <crystal_ball.scad>;
        
        module test_crystal_ball_pie(shape_pts) {
            echo("==== test_crystal_ball_phi ====");

            expected = [[0, 0], [6, 0], [5.1962, 3], [3, 5.1962], [0, 6]];
            
            assertEqualPoints(expected, shape_pts);
        }
            
        crystal_ball(
            radius = 6, 
            theta = 270,
            phi = 90,
            $fn = 12
        );   
    }      

    module test_theta_phi() {
        echo("==== test_crystal_ball_theta_phi ====");
        
        include <crystal_ball.scad>;
        
        module test_crystal_ball_pie(shape_pts) {

            expected = [[0, 0], [5.1392, 2.9671], [4.8541, 3.5267], [3.5267, 4.8541], [2.9671, 5.1392]];
            
            assertEqualPoints(expected, shape_pts);
        }
            
        crystal_ball( 
            radius = 6, 
            theta = [-30, 270],
            phi = [30, 60]
        );  
    }        
    
    test_a_ball();
    test_theta();
    test_phi();
    test_theta_phi();
}

test_crystal_ball();