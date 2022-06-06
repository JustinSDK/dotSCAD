use <curve.scad>;
use <shape_circle.scad>
use <path_extrude.scad>
use <bezier_curve.scad>
use <surface/sf_splines.scad>
use <surface/sf_thicken.scad>

$fn = 48;
t_step = 0.05;

rotate([90, 0, 0])
    ms_clippy();

module ms_clippy() {
    clip_path = curve(t_step, [[15, 15, 0], [5.75, 14.5, 1], [2, 4.5, 0], [-3.5, 8, 0.25],  [-1.5, 24, 0.75], [4, 25.5, 0], [2.5, 18, 1], [1.5, 9, 0], [-1.5, 9.75, 0],  [-1, 16.5, 1], [-2, 22, 1]]);

    color("Gainsboro")
        path_extrude(shape_circle(.5), clip_path);

    sh_eyebrow = shape_circle(.4);
    eyebrow_path = curve(t_step, [[-7.5, 0, 0], [0.75, 1.25, 0], [4.375, -0.75, 0], [2.5, -0.375, 0]]);

    // eyebrows
    color("black")
    translate([1, 18.5, 1.5]) {
        path_extrude(sh_eyebrow, eyebrow_path, scale = 0.1);
        translate([.75, 1.25, 0])
            sphere(.4);
    }

    color("black")
    translate([-.5, 20.25, 1.25])
    mirror([1, 0, 0])
    rotate(20) {
        path_extrude(sh_eyebrow, eyebrow_path, scale = 0.1);
        translate([.75, 1.25, 0])
            sphere(.4);
    }

    // eyes
    module eye() {
        scale([1, .8, .75]) {
            color("white")
                sphere(1.75);
            color("black")
            translate([0, .1, 1])
                sphere(1.2);
        }
    }

    translate([-2.75, 19.5, 1.6])
    rotate(-5)
        eye();

    translate([2.75, 17, 1.9])
    rotate(-10)
        eye();

    // base
    bezier = function(points) bezier_curve(t_step, points);
    g = sf_splines([
        [[-10, 1.5, 6], [-4, -4, 6], [-1, 5.5, 6], [10, 0, 6]], 
        [[-10, 2.5, 1], [0, -3, 0], [2, 11.5, 1], [10, 0, 1]], 
        [[-10, -0.5, -4], [-4, 3, -6], [-1, 5.5, -4], [10, 4, -4]], 
        [[-10, -0.5, -6.3], [-4, -4, -6.3], [-1, 5.5, -6.3], [10, 4, -6.3]]
    ], bezier);

    color("Yellow")
        sf_thicken(g, .75);
}