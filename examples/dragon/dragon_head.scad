use <ellipse_extrude.scad>
use <curve.scad>
use <sweep.scad>
use <matrix/m_transpose.scad>
use <shape_trapezium.scad>
use <ptf/ptf_rotate.scad>
use <bezier_curve.scad>
use <path_extrude.scad>
use <shape_circle.scad>
use <polyhedra/octahedron.scad>

dragon_head();

module dragon_head() {
    module hair() { 
        module face_fin() {
            t_step = 0.05;

            points = bezier_curve(t_step, 
                [[-32, -31.5, -23.5], [39, 2, -15], [10, 15, 2], [25, 15, 10]] * 0.25
            );

            c = shape_circle(2.8, $fn = 3);
            
            translate([9.5, 0, 0])
            rotate([-25, 0, 25])
            translate([-8, 9, 20])
            rotate([45, -5, 80])
            scale([.5, 1.17, 1.4])
                path_extrude(c * 1.2, points, scale = 0.05, twist = -60);   
                
            points2 = bezier_curve(t_step, 
                [[-65, -35, -21], [-5, -5, -15], [-15, -20, 5], [-5, 15, 10]] * 0.25
            );

            translate([13.5, -.1, -1.2])
            rotate([-26.5, 0, 25])
            translate([-8, 9, 20])
            rotate([60, -15, 70])
            scale(.75)
            scale([.5, 1.25, 1.5])
                path_extrude(c * 1.45, points2, scale = 0.05, twist = -60);   
        }
        
        union()
        for(i = [0:35]) {
            rotate(i * 12 + rands(0, 5, 1, i)[0]) 
            translate([0, -11.5, .2]) 
            rotate([rands(0, 2, 1, i)[0], 0, 0]) 
            linear_extrude(10 + rands(0, 5, 1, i)[0], scale = 0.05, twist = 50 - rands(0, 100, 1, seed = i + 1)[0]) 
            translate([0, 10, 0]) 
                circle(3.5, $fn = 6);    
        }

        face_fin();
        mirror([0, 1, 0])
            face_fin();
    }


    module middle_horn() {        
        t_step = 0.05;

        p0 = [0, 0, -.4];
        p1 = [0, 0, 5];
        p2 = [0, -5, 7];
        p3 = [0, -5, 10];

        points = bezier_curve(t_step, 
            [p0, p1, p2, p3] 
        );

        c = shape_circle(2.8, $fn = 4);
        path_extrude(c, points, scale = 0.05);
    }

    module one_horn() {        
        t_step = 0.05;

        p0 = [0, -10, -.4];
        p1 = [0, 0, 10];
        p2 = [5, -5, 20];
        p3 = [-10, 10, 30];

        points = bezier_curve(t_step, 
            [p0, p1, p2, p3] * 0.75
        );

        c = shape_circle(2.8, $fn = 5);
        rotate([30, 20, 0])
        translate([2, 3, 9])
        rotate([45, 20, 15])
            path_extrude(c, points, scale = 0.05, twist = -60);
    }
    
    module mouth() {
        path1 = curve(0.4, [[0, -8, -1], [0, -11, .25], [0, -12, 5], [0, -9, 5], [0, -4, 6], [0, -0.5, 8], [0, 5, 6.5], [0, 8, 6], [0, 12, 1], [0, 16, 0]]);
        path2 = [for(p = path1) ptf_rotate(p, [0, -12, 0]) * 0.9 + [-2, 0, 0]];
        path3 = [for(i = [0:len(path1) - 1]) [-i / 6 - 1.5, i / 1.65 - 9, 0]];
        path4 = [for(p = path3) [-p[0], p[1], p[2]]];
        path5 = [for(p = path2) [-p[0], p[1], p[2]]];

        translate([-.25, 0, -2]) 
        rotate([90, 0, -90]) 
            sweep(m_transpose([path1, path2, path3, path4, path5]));

        translate([-.15, 0, -3.3]) 
        rotate([90, 0, -90]) 
        ellipse_extrude(5.5, slices = 3) 
            polygon([
                [1.003, -10], 
                [3.92192, -7.56368],
                [4, -3.43632], 
                [5, 0], 
                [6.5, 3.25], 
                [6.5, 6.43632], 
                [5.65, 9.5], 
                [5.5, 9.75], 
                [-5.5, 9.75], 
                [-5.65, 9.5], 
                [-6.5, 6.43632], 
                [-6.5, 3.25], 
                [-5, 0], 
                [-4, -3.43632], 
                [-3.92192, -7.56368], 
                [-1.003, -10]
            ]);    

        translate([-0.025, 0, 0]) 
        scale([1.5, 1, 1])
        intersection() {       
            mirror([1, 0, 0]) 
            translate([0, 0, -2.25]) 
            rotate([85, 0, -90])
            ellipse_extrude(4, slices = 2) 
                polygon([
                    [1.003, -10], 
                    [3.5, -7.56368],
                    [4, -3.43632], 
                    [5, 0], 
                    [6.5, 2.25], 
                    [6.7, 6.43632], 
                    [5.5, 8.75], 
                    [5.25, 8.75], 
                    [-5.25, 9], 
                    [-5.5, 9], 
                    [-6.7, 6.43632], 
                    [-6.5, 2.25], 
                    [-5, 0], 
                    [-4, -3.43632], 
                    [-3.5, -7.56368], 
                    [-1.003, -10]
                ]);       

            jpath1 = curve(0.4, [[-10, 16], [0, 8], [4, 5],  [3, 0], [2, -5], [2, -10], [0, -13.5], [-3, -14]]);
            rotate([90, -4, 0])
            linear_extrude(25, center = true)
                polygon(jpath1);
        }
    
        translate([-0.15, -2.5, -11])
        rotate([0, 95, 0])
        linear_extrude(1.4, scale = 0.1)
        translate([.4, 0, 0])
            circle(.5, $fn = 6);

        translate([-0.15, 2.5, -11])
        rotate([0, 95, 0])
        linear_extrude(1.5, scale = 0.1)
        translate([.4, 0, 0])
            circle(.5, $fn = 6);
    }
    
    module one_eye() {
        translate([-5, 2.5, -2])
        rotate([-5, -8, -10]) 
        scale([1, 1, 1.75]) 
            sphere(1.75, $fn = 6);      

        translate([-5, 3.75, -2.25]) 
        rotate([-45, 0, 75]) 
            octahedron(0.625, detail = 1);                      
    }
    
    module one_beard() {
        translate([-10.15, -12, -10])
        rotate(180) 
        linear_extrude(8, scale = 0.15, twist = 35) 
        translate([-9, -10, 0]) 
            circle(1, $fn = 8);    
    }
    
    rotate([0, 15, 0]) 
    translate([0, 0, -25 / 2]) 
    scale(1.15) {
        scale([0.8, 0.9, 1]) hair();

        translate([0, 0, 2]) 
        {
            rotate(-90) {
                one_horn();
                mirror([-1, 0, 0]) 
                    one_horn();  
                
                translate([0, -5, 0])
                    middle_horn();

                translate([0, -5, 5])
                scale([.4, .4, .45])
                    middle_horn();
            }

            mouth();

            one_eye();
            mirror([0, 1, 0]) one_eye();
            
            one_beard();
            mirror([0, 1, 0]) one_beard();
        }        
    }
}