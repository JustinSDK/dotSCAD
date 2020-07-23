use <bezier_curve.scad>;
use <ellipse_extrude.scad>;
use <path_extrude.scad>;
use <shape_circle.scad>;
use <torus_knot.scad>;
use <util/reverse.scad>;

torus_knot_dragon();

module torus_knot_dragon() {
    phi_step = 0.04;

    knot = torus_knot(2, 3, phi_step);
    dragon_body_path = reverse([for(i = [9:len(knot) - 3]) knot[i]]);

    body_shape = concat(
        bezier_curve(0.25, 
            [
                [30, -35], [16, 0], [4, 13], 
                [3, -5], [0, 26], [-3, -5],
                [-4, 13],  [-16, 0], [-30, -35]
            ]
        ),
        bezier_curve(0.25, 
            [[-22, -35], [-15, -45], [0, -55], [15, -45], [22, -35]]
        )
    );    

    
    pts = [for(p = body_shape) p * 0.015];
    p = dragon_body_path[0];
    
    path_extrude(pts, concat([p + [0.00001, 0.0000055, 0.000008]], dragon_body_path), scale = 0.9);

    translate([2.975, -0.75, -0.75])      
    scale(0.01825)
    rotate([-52, -9, -25]) 
    dragon_head(); 
    
    translate([1.84, 1.635, -0.885])
    rotate([104.95, -154.35, 66.25])
    ellipse_extrude(1.2, slices = 7, twist = 15)
    scale(0.9 * 0.0150)
        polygon(body_shape);
}
   
module dragon_head() {
    module palate() {
        t_step = 0.15;
        
        palate_shape = concat(
            bezier_curve(0.25, 
                [
                    [31, -35], [19, 0], [8, 15], [-8, 12], [-19, 0], [-31, -35]
                ]
            ),
            bezier_curve(0.25, 
                [[-20, -35], [-8, -20], [8, -20], [20, -35]]
            )
        );
        
        palate_path = bezier_curve(t_step, 
            [[0, -110, 30], [0, -100, 25], [0, -80, 50], [0, -55, 130], [0, -20, -95], [0, 5, 105], [0, 10, 30], [0, 10, 25]]
        );    
        
        path_extrude(palate_shape, palate_path, scale = 0);    
    }
    
    module jaw() {
        t_step = 0.2;
        
        jaw_shape = concat(
            bezier_curve(t_step, 
                [
                    [-20, 16], [-16, -5], [-8, -25], 
                    [8, -25], [16, -5], [20, 16]
                ]
            ),
            bezier_curve(t_step, 
                [[15, 14], [8, 0], [-8, 0], [-15, 14]]
            )
        );
        
        jaw_path = bezier_curve(t_step, 
            [[0, -60, -5], [0, 5, 0], [0, 10, 0], [0, 35, 39], [0, 25, 40]]
        );    

        path_extrude(jaw_shape, jaw_path, scale = 0);    
    }  
    
    
    module horns() {
        path1 = bezier_curve(0.15, 
                [
                    [12, -40, 15],
                    [40, -38, 0],
                    [30, -60, -10],
                    [50, -90, -30]
                ]
        );
        
        shape1 = shape_circle(7, $fn = 6);
        
        path_extrude(shape1, path1, scale = 0); 
        mirror([1, 0, 0])
            path_extrude(shape1, path1, scale = 0); 
            
        path2 = bezier_curve(0.15, 
                [
                    [12, -42, 15],
                    [30, -17, 16],
                    [35, -20, 0],
                    [40, -40, -10]
                ]
        );
        
        shape2 = shape_circle(7, $fn = 5);
        
        path_extrude(shape2, path2, scale = 0);    
        mirror([1, 0, 0])      
             path_extrude(shape2, path2, scale = 0);    


        path3 = bezier_curve(0.15, 
                [
                    [10, -40, 4],
                    [20, -60, 10],
                    [15, -70, -5],
                    [15, -125, 0]
                ]
        );
        
        shape3 = shape_circle(12, $fn = 6);
        
        path_extrude(shape3, path3, twist = 60, scale = 0); 
        mirror([1, 0, 0]) 
            path_extrude(shape3, path3, twist = 60, scale = 0); 
            
        path4 = bezier_curve(0.15, 
                [
                    [0, 10, 65],
                    [0, 5, 70],
                    [0, 10, 75],
                    [0, 5, 85],
                ]
        );  

        path_extrude(shape_circle(5, $fn = 5), path4, scale = 0);    

        path5 = bezier_curve(0.15, 
                [
                    [0, 0, 65],
                    [0, -5, 70],
                    [0, 0, 70],
                    [0, -5, 75],
                ]
        );  

        path_extrude(shape_circle(3, $fn = 5), path5, scale = 0);       

        path6 = bezier_curve(0.15, 
                [
                    [0, -18, 45],
                    [0, -20, 55],
                    [0, -15, 65],
                    [0, -20, 75],
                ]
        );  

        path_extrude(shape_circle(6, $fn = 6), path6, scale = 0);            
    }
    
    module tone() {
        path1 = bezier_curve(0.15, 
                [
                    [0, -40, -5],
                    [5, 0, 15],
                    [-5, 5, 20],
                    [0, 10, 30],
                    
                ]
        );
        
        shape1 = shape_circle(6, $fn = 6);
        
        
        path_extrude(shape1, path1, scale = 0); 
    }
    
    module eyes() {
        path5 = bezier_curve(0.2, 
                [
                    [0, 0, 0],
                    [0, -5, 5],
                    [0, 0, 8],
                    [1, -5, 12],
                ]
        );  
    
        module eye() {
            eye_shape = shape_circle(5, $fn = 6);
            
            translate([12, -40, 30.5]) 
            rotate([-40, 0, 8])
            scale([0.7, 1, 0.7])
            union() {
                rotate([-40.25, 0, 0])
                    path_extrude(eye_shape, path5, scale = 0); 
                rotate(180)
                mirror([0, 0, 1])
                rotate([-40.25, 0, 0])
                    path_extrude(eye_shape, path5, scale = 0);
            }           
            translate([10.5, -36, 28.5]) 
                sphere(5, $fn = 18);
        } 
        
        eye();
        mirror([1, 0, 0])
            eye();
    }
    
    module neck() {
        neck_shape = concat(
            bezier_curve(0.25, 
                [
                    [31, -35], [19, 0], [8, 15], [-8, 12], [-19, 0], [-31, -35]
                ]
            ),
            bezier_curve(0.25, 
                [[-20, -35], [-8, -20], [8, -20], [20, -35]]
            )
        );
        
        translate([0, -64.5, -1])
        rotate([165, 0, 0])
        linear_extrude(30, scale = 0.9)
            scale(0.95)
            polygon(neck_shape);    
    }
    
    rotate([-45, 0, 0])
    union() {
        rotate([45, 0, 0])
        translate([0, 50, 9.5])
            palate();
        
        jaw();
        horns();
        tone();
        eyes();
        
        neck();
    }

}