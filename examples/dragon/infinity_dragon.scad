use <along_with.scad>
use <fibonacci_lattice.scad>
use <polyhedron_hull.scad>
use <dragon_head.scad>
use <dragon_scales.scad>
use <dragon_foot.scad>
use <experimental/lemniscate_2circles.scad>
use <path_extrude.scad>
use <bezier_curve.scad>

rotate([0, 90, 180])
    infinity_dragon();

module one_segment(body_r, body_fn, one_scale_data) {
    // scales
    rotate([-90, 0, 0])
        dragon_body_scales(body_r, body_fn, one_scale_data);


    points = [[0, 0, 0], [0, .1, 1], [0, 1, 1.5]] * 6;
    path = bezier_curve(0.1, points);

    // dorsal fin
    translate([0, 3.2, -3]) 
    rotate([-61, 0, 0]) 
    path_extrude([[0, -.25], [0.5, 0], [0, .75], [-0.5, 0]] * 6, path, scale = .05);
    
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
    translate([1, 0, -1])
    rotate([0, -12, 0])
    scale([.8, 1, 1])
        hair();

    module hair() {
        tail_hair = [
            [4, -1],
            [8, -1.5],
            [10, -1],
            [13, .5],
            [9, -0.2],
            [10, 0],
            [14, 3],
            [17, 9.5],
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
            [2, 8.5],
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

            scale([.7, .7, .9])
            translate([2, 0, -5])
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

module infinity_dragon() {
    function __angy_angz(p1, p2) = 
        let(
            dx = p2.x - p1.x,
            dy = p2.y - p1.y,
            dz = p2.z - p1.z,
            ya = atan2(dz, sqrt(pow(dx, 2) + pow(dy, 2))),
            za = atan2(dy, dx)
        ) [ya, za];
        
    body_path0 = lemniscate_2circles(30, 5.25, $fn = 44);
    body_path = concat(
        [for(i = [22:len(body_path0) - 1]) body_path0[i]],
        [for(i = [0:11]) body_path0[i]]
    );
    leng_body_path = len(body_path);
    angy_angz = __angy_angz(body_path[16], body_path[17]);

    translate(body_path[0] + [0, -1.5, 0])
    scale(1)
    rotate([93, angy_angz[0] + 2, angy_angz[1] - 75])
        dragon_head();

    body_r = 6;
    body_fn = 12;
    scale_fn = 4;
    scale_tilt_a = 6;
    one_body_scale_data = one_body_scale(body_r, body_fn, scale_fn, scale_tilt_a);

    along_with(body_path, scale = [0.45, 0.7, 0.45])    
    rotate([0, 0, -90])
        one_segment(body_r, body_fn, one_body_scale_data);

    ayz = __angy_angz(body_path[leng_body_path - 2], body_path[leng_body_path - 1]);

    translate([0, 0, 0])
    translate(body_path[leng_body_path - 1])
    rotate([0, ayz[0] + 95, ayz[1]])
    mirror([0, 0, 1])
    rotate(-12)
    scale([0.5, 0.5, 0.85])
    rotate([0, 0, 126])
        tail();

    translate([-20, -20, -5]) 
    rotate([-30, 0, 0])
    rotate([0, 30, 0])
    rotate([-60, 120, -90]) 
    scale(0.85)
        foot();

    translate([-15, -17.5, -3]) 
    rotate([0, -30, -50])
    rotate([-60, 120, -90]) 
    mirror([1, 0, 0])
    scale(0.85)
        foot();

    // translate([65, -15, -.5]) 
    // rotate([-10, 0, 25])
    // rotate([-90, 60, 70]) 
    // scale(0.8)
    //     foot();
        
    // translate([63.5, -13, 1]) 
    // rotate([-50, -55, -120])
    // rotate([-20, 150, -80]) 
    // mirror([1, 0, 0])
    // scale(0.8)
    //     foot();

    translate([-10.5, -8, 11])
        polyhedron_hull(fibonacci_lattice(66, 7.4));
}