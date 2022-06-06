use <polyline_join.scad>
use <turtle/t3d.scad>
use <util/rand.scad>

trunk_leng = 50;
branch_scale = 0.7;
branch_angle = 30;
width = 2;
$fn = 4;

module line(t1, t2, start_width, end_width) {
    polyline_join([t3d(t1, "point"), t3d(t2, "point")]) {
        sphere(start_width / 2);
        sphere(end_width / 2);
    }
}

module shoot(t, trunk_leng, branch_scale, branch_angle, width) {
    t2 = t3d(t, "forward", leng = trunk_leng);
    line(t, t2, width, width);

    branch_leng = trunk_leng * branch_scale;
    
    color("green") {
        t3 = t3d(t2, "turn", angle = branch_angle);
        line(
            t2, 
            t3d(t3, "forward", leng = branch_leng), 
            width,
            width * rand(1, 3)
        );

        t4 = t3d(t2, "turn", angle = -branch_angle);  
        line(
            t2, 
            t3d(t4, "forward", leng = branch_leng), 
            width,
            width * rand(1, 3)
        );
    }
}

module tree(t, trunk_leng, branch_scale, branch_angle, width) {
    if(trunk_leng > width * 2) {
        t2 = t3d(t, "forward", leng = trunk_leng * rand(0.6, 1));
        line(t, t2, trunk_leng / 3, trunk_leng / 3 * branch_scale);

        rolled = t3d(t2, "roll", angle = 120 * rand(0.6, 1));
        branch_leng = trunk_leng * branch_scale;
        
        t3 = t3d(rolled, "turn", angle = branch_angle * rand(0.6, 1));
        tree(t3, branch_leng, branch_scale, branch_angle, width);

        t4 = t3d(rolled, "turn", angle = -branch_angle * rand(0.6, 1));        
        tree(t4, branch_leng, branch_scale, branch_angle, width);
    }
    else {
        shoot(t, trunk_leng, branch_scale, branch_angle, width);
    }
}

tree(t3d(), trunk_leng, branch_scale, branch_angle, width);