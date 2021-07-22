use <shear.scad>;
use <along_with.scad>;
use <bezier_smooth.scad>;
use <util/reverse.scad>;
use <util/dedup.scad>;
use <turtle/lsystem3.scad>;
use <curve.scad>;
use <dragon_head.scad>;

hilbert_dragon();

module hilbert_dragon() {
    module scales(ang, leng, radius, height, thickness) {
        module one_scale() {
            rotate([0, ang, 0]) 
            shear(sx = [0, -1.5])
            linear_extrude(thickness, center = true) 
            scale([leng, 1.6]) 
                circle(1, $fn = 4);    
        }

        for(a = [0:45:315]) {
            hull() {
                rotate(a) 
                translate([radius, 0, height]) 
                    one_scale();
                    
                rotate(a + 15) 
                translate([radius, 0, height + 1.75]) 
                    one_scale();
            }
        }
    }

    module one_segment() {
        // scales
        scale([1, 0.8, 1]) union() {
            scales(60, 4, 5, 0, 1.5);
            scales(75, 2.5, 5, -4, 1.25);
            scales(100, 1.25, 4.5, -7, 1);
            scales(110, 1.25, 3, -9, 1);
//            scales(120, 2.5, 2, -9, 1);   
        }
        
        // dorsal fin
        translate([0, 4, -1.5]) 
        rotate([-105, 0, 0]) 
        shear(sy = [0, .75])
        linear_extrude(5, scale = 0.15)
            square([2.5, 4], center = true);            

        hull() {
            // belly
            translate([0, -2.5, 1]) 
            rotate([-10, 0, 0]) 
            scale([1.1, 0.8, 1.25])  
                sphere(5.8, $fn = 8); 

            translate([0, 0, -1.65]) 
            rotate([-5, 0, 0]) 
            scale([1, 0.8, 1.6])  
                sphere(5.5, $fn = 8); 
        }
    }

    lines = hilbert_curve();
    hilbert_path = dedup(
        concat(
            [for(line = lines) line[0]], 
            [lines[len(lines) - 1][1]])
        );
    smoothed_hilbert_path = bezier_smooth(hilbert_path, 0.45, t_step = 0.2);

    dragon_body_path = reverse([for(i = [1:len(smoothed_hilbert_path) - 2]) smoothed_hilbert_path[i]]);
     
    along_with(dragon_body_path, scale = 0.6)    
    rotate([90, 0, 0]) 
    scale(0.035)  
        one_segment();
    
    // tail
    translate([0, 0, -0.62])
    rotate(-5)
    scale(0.0285)
    mirror([0, 0, 1]) 
        scales(120, 2.5, 2, -9, 1);

    translate([0, 0, -2.5])        
    scale(0.035)         
        dragon_head([0, 0]);     
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