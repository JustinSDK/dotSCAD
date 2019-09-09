include <bezier_curve.scad>;
include <bezier_surface.scad>;
include <function_grapher.scad>;
include <hollow_out.scad>;
include <rounded_extrude.scad>;
include <bend_extrude.scad>;
include <ellipse_extrude.scad>;
include <shape_ellipse.scad>;

holder_height = 80;
holder_round_r = 5;
feet_height = 15;

module vampire_holder() {
    $fn = 48;
        
    module feet() {
        module foot() {
            ellipse_extrude(semi_minor_axis = feet_height)    
                polygon(shape_ellipse(axes  = [20, 30]));
        }
        
        translate([25, 0, 0]) foot();
        translate([-25, 0, 0]) foot();
    }

    module holder() {
        radius = 30;

        rounded_extrude(radius * 2, round_r = holder_round_r) 
            circle(radius);
                
        translate([0, 0, holder_round_r])
            linear_extrude(holder_height) 
                hollow_out(shell_thickness = 4) circle(30 + 5);
    }

    module sun_glasses() {
        glasses_path = [[0, 5], [40, 10], , [15, -10], [0, -5]];
        thickness = 4;
        
        rotate(-135) 
            bend_extrude(size = [80, 20], thickness = thickness, angle = 90) 
                translate([40, 10]) 
                
                    union() {
                        polygon(glasses_path);
                        mirror([1, 0, 0]) polygon(glasses_path);
                    }

    }

    module cloak() {
        t_step = 0.05;
        thickness = 4;

        ctrl_pts = [
            [[10, 0, -20],  [60, 0, 55],   [90, 0, 60], [150, 0, -20]],
            [[85, 50, -25], [55, 40, 10], [115, 30, 35], [80, 50, -40]],
            [[25, 50, 100], [60, 70, 70],  [90, 70, 70],  [150, 60, 70]],
            [[0, 70, 100], [30, 80, 90], [90, 80, 90],  [150, 80, 90]]
        ];

        g = bezier_surface(t_step, ctrl_pts);
        
        rotate([-90, 0, 0])  
            function_grapher(g, thickness, style = "HULL_FACES", $fn = 3);       
    }

    color("black") 
        feet();

    color("white") 
        translate([0, 0, feet_height - holder_round_r]) 
            holder();

    color("black")  
        translate([0, 12.5, holder_height * 5 / 6]) 
            sun_glasses(); 

    color("red") 
        translate([-80, holder_round_r + 0.5, holder_height + feet_height - holder_round_r])
            cloak();
}

vampire_holder();