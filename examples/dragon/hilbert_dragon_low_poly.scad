use <bezier_smooth.scad>
use <bezier_curve.scad>
use <ellipse_extrude.scad>
use <path_extrude.scad>
use <util/reverse.scad>
use <util/dedup.scad>
use <turtle/lsystem3.scad>
use <dragon_head_low_poly.scad>

hilbert_dragon_low_poly();

module hilbert_dragon_low_poly() {
    lines = hilbert_curve();
    hilbert_path = dedup([each [for(line = lines) line[0]], lines[len(lines) - 1][1]]);
    smoothed_hilbert_path = bezier_smooth(hilbert_path, 0.48, t_step = 0.2);

    dragon_body_path = reverse([for(i = [1:len(smoothed_hilbert_path) - 4]) smoothed_hilbert_path[i]]);

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

    
    pts = [for(p = body_shape) p * 0.007];
    p = dragon_body_path[0];
    
    path_extrude(
        pts, 
        [p + [-.25, 0, -.05], each [for(i = [1:len(dragon_body_path) - 1]) dragon_body_path[i]]], 
        scale = 0.9
    );

    translate([0, 0, -2.81])        
    scale(0.01)
    rotate([-55, 0, 90]) 
    dragon_head_low_poly(); 
    
    translate([0, 0, -0.525])
    rotate([0, -7, 0])
    rotate(90)
    ellipse_extrude(0.5, slices = 4, twist = 15)
    scale(0.9 * 0.007)
        polygon(body_shape);
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