use <helix.scad>
use <along_with.scad>
use <curve.scad>
use <sweep.scad>
use <shape_circle.scad>
use <bezier_curve.scad>
use <path_scaling_sections.scad>
use <experimental/worley_sphere.scad>
use <dragon_head.scad>
use <dragon_scales.scad>
use <dragon_foot.scad>
use <path_extrude.scad>
use <bezier_curve.scad>

r1 = 25;
r2 = 15;
levels = 3;
level_dist = 20;

module one_segment(body_r, body_fn, one_scale_data) {
    // scales
    rotate([-90, 0, 0])
        dragon_body_scales(body_r, body_fn, one_scale_data);

    points = [[0, 0, 0], [0, .1, 1], [0, 1, 1.5]] * 4;
    path = bezier_curve(0.1, points);

    // dorsal fin
    translate([0, 3, -3]) 
    rotate([-82.5, 5, 30]) 
    path_extrude([[0, -.25], [0.5, 0], [0, .75], [-0.5, 0]] * 4, path, scale = .05);            
            
    // belly    
    translate([0, -2.5, .8]) 
    rotate([-5, 0, 0]) 
    scale([1, 1, 1.4])  
        sphere(body_r * 0.966, $fn = 8); 
    
}

module tail() {
    $fn = 4;
    tail_scales(75, 2.5, 4.25, -4, 1.25);
    tail_scales(100, 1.25, 4.5, -7, 1);
    tail_scales(110, 1.25, 3, -9, 1);
    tail_scales(120, 2.5, 2, -9, 1);   

    translate([0, -.5, -5])
    rotate([-5, -5, 5])
    scale([.9, 1, .55])
        hair();

    module hair() {
        tail_hair = [
            [3, -1],
            [5, -1.5],
            [8, -1],
            [9.5, 0],
            [8, -0.4],
            [6.5, -0.3],
            [8, 0],
            [10, 1],
            [14, 5],
            [17, 10],
            [14, 8],
            [12, 7],
            [9, 6],
            [11.5, 10],
            [13, 12],
            [16, 14],
            [12, 13],
            [8, 11],
            [10, 14],
            [5, 11],
            [3, 8.5],
            [-1, 3]
        ];

        rotate([-2.5, 0, 0])
        translate([-1, .5, 5.5])
        scale([1.1, 1, 1.3]) {
            translate([2, 0, -3])
            scale([2, 1, .8])
            rotate([-90, 70, 15])
            linear_extrude(.75, center = true)
                polygon(tail_hair);

            scale([.8, .9, .6])
            translate([2, 0, -5])
            scale([1.75, 1, .8])
            rotate([-90, 70, 15]) {
                linear_extrude(1.5, scale = 0.5)
                    polygon(tail_hair);
                mirror([0, 0, 1])
                linear_extrude(1.5, scale = 0.5)
                    polygon(tail_hair);
            }

            scale([.6, .7, .9])
            translate([2, 0, -4])
            scale([2, 1, .85])
            rotate([-90, 70, 15]) {
                linear_extrude(3.5, scale = 0.5)
                    polygon(tail_hair);
                mirror([0, 0, 1])
                linear_extrude(3.5, scale = 0.5)
                    polygon(tail_hair);
            }
        }    
    }
}

module mountain_dragon() {
    path_pts = helix(
        radius = [r1, r2], 
        levels = levels, 
        level_dist = level_dist, 
        vt_dir = "SPI_DOWN", 
        rt_dir = "CLK", 
        $fn = 32
    );

    function __angy_angz(p1, p2) = 
        let(
            dx = p2[0] - p1[0],
            dy = p2[1] - p1[1],
            dz = p2[2] - p1[2],
            ya = atan2(dz, sqrt(dx * dx + dy * dy)),
            za = atan2(dy, dx)
        ) [ya, za];
        
    angy_angz = __angy_angz(path_pts[0], path_pts[1]);
    
    body_r = 5.25;
    body_fn = 12;
    scale_fn = 4;
    scale_tilt_a = 6;

    one_body_scale_data = one_body_scale(body_r, body_fn, scale_fn, scale_tilt_a);
    scale(1.075) 
    along_with(path_pts, twist = 45, scale = [0.575, 0.575, 0.85], method = "EULER_ANGLE")    
        one_segment(body_r, body_fn, one_body_scale_data);
    
    translate([27.25, 4, 1])
    rotate([-78, 0, 0])
    rotate([0, 0, 125])
    scale([.5, .725, 1.5])
        tail();

    translate([16, 0, 63]) 
    rotate([95, 5, -5]) 
    rotate([0, angy_angz[0], angy_angz[1]])
        dragon_head();

    rotate([-8, -2, -10])
    translate([12, 2, 44])
    rotate([10, -67.5, -200])
    scale(.7)
        foot();

    translate([13, 2.5, 45.5])
    rotate([-76, -25, -95])
    rotate([0, -20, 0])
    mirror([1, 0, 0])
    scale(.7)
    translate([2, 0, 1])
        foot();

    translate([-13, -13, 13])
    rotate([54, -72, 30])
    rotate(-30)
    scale(.65)
        foot();

    translate([-10, -15.5, 12])
    rotate([-87, -45, 145])
    mirror([1, 0, 0])
    scale(.65)
        foot();
}

module mountain() {
    radius = 20;
    detail = 10;
    amplitude = .1;
    dist = "border"; 

    difference() {
        union() {
            translate([0, 0, 12])
            scale([.925, .85, 2.4])	
                worley_sphere(radius, detail, amplitude, dist, seed = 14);

            translate([4, -4, -15])
            scale([1.04, 1.04, 1])
            rotate(10)
                worley_sphere(radius * 1.2, detail, amplitude, dist, seed = 1);
        }

        translate([0, 0, -102])
        linear_extrude(100)
            square(100, center = true);
    }
}

rotate(180) {
    translate([0, 0, 7]) 
        mountain_dragon($fn = 12);
    translate([-1, -1, 0])
    rotate(67.5)
        mountain();
}