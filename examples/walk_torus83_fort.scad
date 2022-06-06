use <shape_star.scad>
use <hollow_out.scad>

// The idea is from Walk Torus83 Fort.
// https://sketchfab.com/3d-models/walk-torus83-fort-44dc701f676d40f7aa1bee874db6fde9

thickness = 4;
height = 15;
torus_radius = 60;
wall_radius = 71.49;

walk_torus83_fort(torus_radius, thickness, height, $fn = 36);
wall(wall_radius, height, thickness, $fn = 36);

module wall(radius, height, thickness) {
    bk_number = 8;
    half_thickness = thickness / 2;
    ro = radius;
    ri = ro * 0.541196;
    leng = ro / 2.3;
    
    bk_w = leng / bk_number / 2;   
    module bk() {
        for(i = [0:bk_number + 2]) {
            translate([(2 * i + 1) * bk_w, 0]) 
                square([bk_w, bk_w * 2], center = true);
        }
    }    

    module eight_pts_star(r, th) {    
        hollow_out(shell_thickness = th) 
            intersection() {
                rotate(22.5) 
                    polygon(shape_star(ro, ri, 8)); 
                circle(ro * 0.9);
            }
    }

    linear_extrude(height) 
        eight_pts_star(ro - thickness, thickness);

    translate([0, 0, height]) 
    linear_extrude(half_thickness) 
    difference() {
        eight_pts_star(ro - thickness, thickness / 4);
        
        union() {
            for(i = [0:7]) {
                rotate(22.5 + i * 45) 
                translate([-ro, 0]) 
                rotate(-22.5) {
                    bk();
                    rotate(45) bk();
                }
            }
        }
    }
}

module walk_torus83_fort(radius, thickness, height) {
    stair_number = 13;
    leng = radius * 0.56;

    module tower(radius, height) {
        linear_extrude(height) 
            circle(radius);
        translate([0, 0, height]) 
            sphere(radius);
    }

    module stairs(height, n) {
        w = height / n;
        half_w = w / 2;
                
        for(i = [0:n - 1]) {
            translate([w * i + w / 2, w * i + w / 2]) 
                square(w, center = true);
        }
    }

    module walkway(leng, thickness, height, wall_thickness, stair_number) {
        half_leng = leng / 2;
        half_h = height / 2;
        
        module door_df() {
            r = height / 4;
            door_w = height / 3 * 2;
            circle(r);
            translate([0, -height / 3]) 
               square(door_w, center = true);
        }

        module half_door_df() {
            door_w = thickness;
            door_h = height / 3 * 2.5 - door_w;
            half_dw = door_w / 2;
            translate([-thickness * 1.75, -half_h]) {
                square([door_w, door_h]);
                translate([half_dw, door_h]) 
                    circle(half_dw);
            }
        }
        
        tri_points = [[0, 0], [0, height], [-height, 0]];
        leng2 = leng * 0.5;
        half_leng2 = leng2 / 2;
        
        rotate([90, 0, 0]) 
        linear_extrude(thickness, center = true) {
            // walkway with doors
            difference() {
                hull() {   
                    translate([half_leng, 0, 0]) 
                        square([leng, height], center = true);
                    translate([-half_leng, -half_h])
                        polygon(tri_points);
                }
                
                translate([-leng / 2.125, 0]) 
                    door_df();
                
                half_door_df();
            }
            translate([-half_leng - height, -half_h]) 
                stairs(height, stair_number);
                
                // walkway without doors    
            translate([-leng * 2, 0]) 
            rotate([180, 0, 180]) {
                translate([half_leng2, 0]) 
                    square([leng2, height], center = true);
                translate([0, -half_h]) 
                    polygon(tri_points);
                translate([-height, -half_h]) 
                    stairs(height, stair_number);
                
                walk_bottom_leng = 2 * leng - height * 2 - half_leng;
                translate([-walk_bottom_leng - height, -half_h]) 
                    square([walk_bottom_leng, height / stair_number]);
            }                    
        }
    }

    module one_burst(leng, thickness, height, stair_number) {
        half_thickness = thickness / 2;
        offset = leng / 2 + half_thickness;

        half_h = height / 2;
            
        road_width = thickness / 1.5;
        translate([0, -half_thickness - road_width / 2, half_h - half_h / stair_number])
            walkway(leng, road_width, height / stair_number * (stair_number - 1), thickness, stair_number);
    }

    offset = leng / 1.325;
    for(i = [0:7]) {
        rotate(45 * i) 
        translate([offset, offset, 0]) 
            one_burst(leng, thickness, height, stair_number);
        
        rotate(45 * i + 22.5) 
        translate([radius + thickness / 1.75, 0])
            tower(thickness * 1.25, height * 1.125);
    }
}
