use <polyline_join.scad>
use <turtle/t3d.scad>
use <util/rand.scad>
use <shape_circle.scad>
use <util/rands_disk.scad>

use <experimental/circle_packing.scad>

trunk_leng = 1.5;
branch_scale = 0.7;
branch_angle = 30;
width = 1;

$fn = 12;
min_r = .5;
r = 35;
count = 20;

fractal_tree = true;

points = concat(rands_disk(r, count), shape_circle(r));
circles = circle_packing(points, min_r);

if(fractal_tree) {
    for(c = circles) {
        translate([each c[0], c[1] / 12.5])
        rotate([0, -90, rands(0, 360, 1)[0]])
            tree(t3d(), c[1], branch_scale, branch_angle, width, $fn = 5);    
    }
} 
else {
    for(c = circles) {
        translate([each c[0], c[1] * 3])
            sphere(c[1]);    
            
        translate(c[0])
        linear_extrude(c[1] * 3)
            circle(c[1] / 3);
    }
}

translate([0, 0, -width / 10])
linear_extrude(width / 1.5, center = true)
    circle(r, $fn = $fn * 3);
    
module line(t1, t2, start_width, end_width) {
    polyline_join([t3d(t1, "point"), t3d(t2, "point")]) {
        sphere(start_width / 2);
        sphere(end_width / 2);
    }
}

module shoot(t, trunk_leng, branch_scale, branch_angle, width) {
    t2 = t3d(t, "forward", leng = trunk_leng);
    branch_leng = trunk_leng * branch_scale;
        
    color("NavajoWhite")
    line(t, t2, branch_leng * branch_scale, branch_leng);

    color("green") {
        t3 = t3d(t2, "turn", angle = branch_angle);
        line(
            t2, 
            t3d(t3, "forward", leng = branch_leng * rand(1, 2)), 
            branch_leng,
            width * branch_scale * rand(2, 4),
            $fn = rand(4, 6)
        );

        t4 = t3d(t2, "turn", angle = -branch_angle);  
        line(
            t2, 
            t3d(t4, "forward", leng = branch_leng * rand(1, 2)), 
            branch_leng,
            width * branch_scale * rand(2, 4),
            $fn = rand(4, 6)
        );
    }
}

module tree(t, trunk_leng, branch_scale, branch_angle, width) {
    if(trunk_leng > width * 2) {
        t2 = t3d(t, "forward", leng = trunk_leng * rand(0.6, 1));
        
        color("NavajoWhite")
        line(t, t2, trunk_leng / 3, trunk_leng / 3 * branch_scale);

        rolled = t3d(t2, "roll", angle = 120 * rand(0.6, 1));
        branch_leng = trunk_leng * branch_scale;
        
        t3 = t3d(rolled, "turn", angle = branch_angle * rand(0.6, 1));
        tree(t3, branch_leng, branch_scale, branch_angle, width);

        t4 = t3d(rolled, "turn", angle = -branch_angle * rand(0.6, 1));        
        tree(t4, branch_leng, branch_scale, branch_angle, width);
    }
    else {
        branch_leng = trunk_leng * branch_scale;
        shoot(t, branch_leng, branch_scale, branch_angle, width);
    }
}



