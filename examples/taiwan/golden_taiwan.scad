include <shape_taiwan.scad>;
include <circle_path.scad>;
include <rotate_p.scad>;
include <golden_spiral.scad>;
include <cross_sections.scad>;
include <polysections.scad>;
include <golden_spiral_extrude.scad>;
include <bezier_curve.scad>;
include <bezier_surface.scad>;
include <function_grapher.scad>;

// smaller values are better
taiwan_fineness = 5;  

// smaller values are better
wave_fineness = 0.05;  

module golden_taiwan(taiwan_fineness, wave_fineness) {
    
    module taiwan() {
        mirror_taiwan = [for(pt = shape_taiwan(15)) [pt[0] * -1, pt[1]]];

        translate([127.5, 42.5, 83]) golden_spiral_extrude(
            mirror_taiwan, 
            from = 1,  
            to = 10, 
            point_distance = taiwan_fineness,
            scale = 10
        );    
    }

    module wave() {
        t_step = wave_fineness;
        thickness = 100;

        ctrl_pts = [
            [[0, 0, 20],  [60, 0, -35],   [90, 0, 60],    [200, 0, 5]],
            [[0, 50, 30], [100, 60, -25], [120, 50, 120], [200, 50, 5]],
            [[0, 100, 0], [60, 120, 35],  [90, 100, 60],  [200, 100, 45]],
            [[0, 123, 0], [60, 123, -35], [90, 123, 60],  [200, 123, 45]]
        ];

        g = bezier_surface(t_step, ctrl_pts);

        difference() {
            function_grapher(g, thickness);
            translate([-1, -1, -120]) cube([220, 130, 110]);
        }    
    }

        taiwan();

        render() wave();
    
}

golden_taiwan(taiwan_fineness, wave_fineness);