use <along_with.scad>
use <dragon_scales.scad>
use <dragon_claw.scad>

module knee() {
    $fn = 4;
    scale([1,0.85, 1]) union() {
        knee_scales(75, 2.5, 4.25, -4, 1.25);
        knee_scales(100, 1.25, 4.5, -7, 1);
        knee_scales(110, 1.25, 3, -9, 1);
        knee_scales(120, 2.5, 2, -9, 1);   
    }
}

module foot() {
    upper_arm_r = 3.6;
    lower_arm_r = 2.7;
    arm_fn = 6;
    scale_fn = 4;
    scale_tilt_a = 6;

    upper_arm_path = [[.5, 1, 10], [1.25, 6.25, 11.25], [2, 11.5, 12.5], [2, 16.75, 13.75], [1.9, 20, 14.25]];
    lower_arm_path = [[2, 22, 14],  [3.5, 21, 10], [4.5, 20.3, 7]];

    upper_arm_scale_data = one_body_scale(upper_arm_r, arm_fn, scale_fn, scale_tilt_a);
    lower_arm_scale_data = one_body_scale(lower_arm_r, arm_fn, scale_fn, scale_tilt_a);

    along_with(upper_arm_path, scale = 0.75, method = "EULER_ANGLE") 
    rotate([-90, 0, 0])
        dragon_body_scales(upper_arm_r, arm_fn, upper_arm_scale_data);

    along_with(lower_arm_path, scale = 0.7, method = "EULER_ANGLE") 
    rotate([-90, 0, 0])
        dragon_body_scales(lower_arm_r, arm_fn, lower_arm_scale_data);
    
    translate([2.25, 14.5, 12.75])
    scale([0.7, 1.15, .8])
    rotate([108, 9, 1])
        knee();

    translate([6.4, 18.95, .25])
    rotate([11, 13, 185])
    scale([1.2, 1.2, 1.2])
        dragon_claw();
}