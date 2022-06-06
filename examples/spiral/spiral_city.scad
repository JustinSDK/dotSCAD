use <archimedean_spiral.scad>
use <arc.scad>
use <rounded_cube.scad>
use <util/reverse.scad>

num_of_buildings = 10;
seed_value = 15; 

spiral_city(num_of_buildings, seed_value);  

module spiral_city(num_of_buildings, seed_value) {
    $fn = 48;
    arm_distance = 30;

    points_angles = archimedean_spiral(
        arm_distance = arm_distance,
        init_angle = 270,
        point_distance = 30,
        num_of_points = num_of_buildings + 1
    ); 

    pts = reverse([for(pa = points_angles) pa[0]]);
    leng_pts = len(pts);

    floor_h = 30;
    roof_h = 7;
    w_size = floor_h / 6;

    for(i = [0:leng_pts - 2]) {
        mid_pt = (pts[i] + pts[i + 1]) / 2;
        arc_r = norm(mid_pt);
        d_pts = norm(pts[i] - pts[i + 1]);
        arc_a = angle(arc_r, d_pts) * (i > leng_pts - 4 ? 0.85 : 0.95); 
        
        is_even = i % 2 == 0;
        half_a = arc_a / 2;
        
        building_h = floor_h * (floor(i / 5 + 1) + (is_even ? floor_h / 65: 0));
        ra_arc = atan2(mid_pt[1], mid_pt[0]) - (i > leng_pts - 4 ? arc_a / 4.5 : arc_a / 5);
        
        translate(mid_pt)
        rotate(ra_arc) {
            difference() {
                union() {
                    linear_extrude(building_h)
                    translate([-arc_r, 0])
                    minkowski() {
                        arc(radius = arc_r, angle = [-half_a, half_a], width = arm_distance / (is_even ? 2.5 : 1.7));
                        circle(1, $fn = 12);
                    }
                }  
                
                // windows
                cubes(i, arm_distance, building_h, w_size, arc_a, arc_r, seed_value);
            }        
            
            roof(i, arm_distance, building_h, roof_h, arc_a, arc_r);
        }
    }
    
    function angle(arc_r, d_pts) = 180 * d_pts / (arc_r * PI);
    
    module cubes(i, arm_distance, building_h, w_size, arc_a, arc_r, seed_value) {
        half_a = arc_a / 2;
        is_even = i % 2 == 0;
        arc_w = arm_distance / (is_even ? 2.5 : 1.7);
          
        rs = is_undef(seed_value) ?
            rands(-1, 1, 4) : 
            rands(-1, 1, 4, seed_value = seed_value + i);
        
        outer_cube_size = [w_size / 2, w_size  + rs[0] , w_size + rs[1]];
        inter_cube_size = [w_size / 2, (w_size + rs[0]) * 0.85, w_size + rs[1]];
        
        h_step = w_size * 1.5;
        h_to = building_h - w_size * 1.5; 
        
        a_from = -half_a  + (rs[3] > 0 ? arc_a / 8 : arc_a / 6);
        a_step = rs[3] > 0 ? arc_a / 4 : arc_a / 3;
        
        outer_cube_p = [arc_r + arc_w / 2, 0, w_size * 0.75];
        inner_cube_p = [arc_r - arc_w / 2, 0, w_size * 0.75]; 
        
        for(h = [0:h_step: h_to]) {                
            translate([-arc_r, 0, h + rs[2] + 1])
            for(a = [a_from:a_step:half_a]) {
                r = is_undef(seed_value) ?
                        rands(0, 1, 1)[0] :
                        rands(0, 1, 1, seed_value = seed_value)[0];
                s = [r > 0.5 ? 2.75 : 1, 1, 1];
                rotate(a) {
                    translate(outer_cube_p)
                    scale(s)
                        rounded_cube(outer_cube_size, 1, center = true, $fn = 7);
                        
                    translate(inner_cube_p)
                    scale(s)
                        rounded_cube(inter_cube_size, 1, center = true, $fn = 7);      
                }                        
            }
        } 
    }
    
    module roof(i, arm_distance, building_h, roof_h, arc_a, arc_r) {
        is_even = i % 2 == 0;
        half_a = arc_a / 2;
        if(is_even) {
            translate([0, 0, building_h])
            linear_extrude(roof_h, scale = [0.1, 0.65], slices = 10)
            translate([-arc_r, 0])    
            minkowski() {
                arc(radius = arc_r, angle = [-half_a * 1.075, half_a * 1.075], width = arm_distance * 0.5);   
                circle(1, $fn = 12);
            }
        }  
        else {
            translate([0, 0, building_h])        
            linear_extrude(roof_h * 0.8, scale = [0.1, 0.65], slices = 10)
            translate([-arc_r, 0])    
            minkowski() {
                arc(radius = arc_r, angle = [-half_a, half_a], width = arm_distance * 0.65);   
                circle(1, $fn = 12);
            }  
        }      
    }    
}