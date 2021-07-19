use <curve.scad>;;
use <shape_circle.scad>;
use <path_extrude.scad>;
use <bezier_curve.scad>;
use <util/reverse.scad>;
use <surface/sf_splines.scad>;
use <surface/sf_thicken.scad>;

$fn = 48;
t_step = 0.05;

ms_paperclip_meme();

module ms_paperclip_meme() {
    clip_path = [[15, 15, 0], [5.75, 14.5, 1], [2, 4.5, 0], [-3.5, 8, 0.25],  [-1.5, 24, 0.75], [4, 25.5, 0], [2.5, 18, 1], [1.5, 9, 0], [-1.5, 9.75, 0],  [-1, 16.5, 1], [-2, 22, 1]];

    color("Gainsboro")
        path_extrude(shape_circle(.5), curve(t_step, clip_path));

    sh_eyebrow = shape_circle(.4);
    eyebrow_path = [[-3, 0, 0], [0.3, .5, 0], [1.75, -0.3, 0], [1, -.15, 0]] * 2.5;

    // eyebrows
    color("black")
    translate([1, 18.5, 1.5]) {
        path_extrude(sh_eyebrow, curve(t_step, eyebrow_path), scale = 0.1);
        translate([.75, 1.25, 0])
            sphere(.4);
    }

    color("black")
    translate([-.5, 20.25, 1.25])
    mirror([1, 0, 0])
    rotate(20) {
        path_extrude(sh_eyebrow, curve(t_step, eyebrow_path), scale = 0.1);
        translate([.75, 1.25, 0])
            sphere(.4);
    }

    // eyes
    translate([-2.75, 19.5, 1.6])
    rotate(-5)
    scale([1, .8, .75]) {
        color("white")
            sphere(1.75);
        color("black")
        translate([0, .1, 1])
            sphere(1.2);
    }

    translate([2.75, 17, 1.9])
    rotate(-10)
    scale([1, .8, .75]) {
        color("white")
            sphere(1.75);
        color("black")
        translate([0, .1, 1])
            sphere(1.2);
    }

    // base
    ctrl_pts = [[[0, 0, 2], [6, 0, -3.5], [9, 0, 6], [20, 0, 0.5]], [[0, 5, 3], [10, 6, -2.5], [12, 5, 12], [20, 5, 0.5]], [[0, 10, 0], [6, 12, 3.5], [9, 10, 6], [20, 10, 4.5]], [[0, 12.3, 0], [6, 12.3, -3.5], [9, 12.3, 6], [20, 12.3, 4.5]]];
    bezier = function(points) bezier_curve(t_step, points);
    g = sf_splines(ctrl_pts, bezier);

    color("Yellow")
    translate([-10, -.5, 6])
    rotate([-90, 0, 0])
        sf_thicken(g, .75);
}