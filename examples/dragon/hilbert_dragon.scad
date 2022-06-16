use <along_with.scad>
use <bezier_smooth.scad>
use <util/reverse.scad>
use <util/dedup.scad>
use <turtle/lsystem3.scad>
use <curve.scad>
use <dragon_head.scad>
use <dragon_scales.scad>
use <path_extrude.scad>
use <bezier_curve.scad>

hilbert_dragon();

module hilbert_dragon() {
    module one_segment(body_r, body_fn, one_scale_data) {
        rotate([-90, 0, 0])
            dragon_body_scales(body_r, body_fn, one_scale_data);

        points = [[0, 0, 0], [0, .1, 1], [0, 1, 1.5]] * 4.5;
        path = bezier_curve(0.1, points);

        // dorsal fin
        translate([0, 3.2, -3]) 
        rotate([-65, 0, 0]) 
        path_extrude([[0, -.25], [0.5, 0], [0, .75], [-0.5, 0]] * 4.5, path, scale = .05);  
        
        translate([0, -2.5, 1]) 
        rotate([-10, 0, 0]) 
        scale([1.1, 0.8, 1.25])  
            sphere(body_r * 1.075, $fn = 8); 
    }

    body_r = 5;
    body_fn = 12;
    scale_fn = 5;
    scale_tilt_a = -3;

    lines = hilbert_curve();
    hilbert_path = dedup([each [for(line = lines) line[0]], lines[len(lines) - 1][1]]);
    smoothed_hilbert_path = bezier_smooth(hilbert_path, 0.45, t_step = 0.15);

    dragon_body_path = reverse([for(i = [1:len(smoothed_hilbert_path) - 2]) smoothed_hilbert_path[i]]);
     
    one_body_scale_data = one_body_scale(body_r, body_fn, scale_fn, scale_tilt_a);
     
    along_with(dragon_body_path, scale = [0.425, 0.6, 0.425])    
    scale(0.035)  
        one_segment(body_r, body_fn, one_body_scale_data);
    
    // tail
    translate([0, -.012, -.54])
    scale([0.017, 0.017, 0.025])
    rotate([0, 0, -12])
    mirror([0, 0, .2]) 
        tail();

    translate([.06, 0, -2.4])        
    scale(0.033)      
    rotate([0, -15, 0])   
        dragon_head();     
}
   
module tail() {
    $fn = 4;
    tail_scales(75, 2.5, 4.25, -4, 1.25);
    tail_scales(100, 1.25, 4.5, -7, 1);
    tail_scales(110, 1.25, 3, -9, 1);
    tail_scales(120, 2.5, 2, -9, 1);   
 
    translate([0, 0, -1.6])
    rotate([0, -25, 0])
    scale([1.3, 1.2, .9])
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
            [12, 1.5],
            [15, 4],
            [17, 10],
            [14, 8],
            [12, 7],
            [9, 6],
            [11.5, 10],
            [13, 12],
            [16, 14],
            [12, 13],
            [8, 11],
            [9, 13],
            [4, 9],
            [2, 8],
            [-1, 3]
        ];

        rotate([-2.5, 0, 0])
        translate([-1, 1, 5.5])
        scale([.8, 1, 1.3]) {
            translate([2, 0, -3])
            scale([2, 1, .8])
            rotate([-90, 70, 15])
            linear_extrude(.75, center = true)
                polygon(tail_hair);

            scale([.85, .9, .6])
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
            rotate([-90, 65, 15]) {
                linear_extrude(3.5, scale = 0.5)
                    polygon(tail_hair);
                mirror([0, 0, 1])
                linear_extrude(3.5, scale = 0.5)
                    polygon(tail_hair);
            }
        }    
    }
}

function hilbert_curve() = 
    let(
        axiom = "A",
        rules = [
            ["A", "B-F+CFC+F-D&F^D-F+&&CFC+F+B//"],
            ["B", "A&F^CFB^F^D^^-F-D^|F^B|FC^F^A//"],
            ["C", "|D^|F^B-F+C^F^A&&FA&F^C+F+B^F^D//"],
            ["D", "|CFB-F+B|FA&F^A&&FB-F+B|FC//"]
        ]
    )
    lsystem3(axiom, rules, 2, 90, 1, 0,  [0, 0, 0]);  