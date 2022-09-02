use <experimental/foliage_scroll.scad>
use <polyline_join.scad>
use <stereographic_extrude.scad>
use <sweep.scad>
use <util/choose.scad>
use <util/reverse.scad>

$fn = 12;
width = 200;
height = 200;
max_spirals = 4; 
angle_step = 360 / $fn; 
min_radius = 15; 
init_radius = rands(min_radius * 2, min_radius * 3, 1)[0];

theta_step = 0.1;
rf_step = 0.1;

climbing_rose();

module climbing_rose() {
    thickness = 0.02;

    theta_from = PI * 1.75;
    theta_to = PI * 15;

    rf_to = 1;
    module rose(thickness, theta_from, theta_to, rf_to, rf_step) {
        function phi(theta) =
            (PI / 2) * exp(-theta / (8 * PI));
            
        function wave(theta) = 
             1 - 0.5 * pow(1.25 * pow(1- ((3.6 * theta) % (2 * PI)) / PI - (theta > 0 ? 0 : 2), 2) - 0.25, 2);

        function g(rf, theta) =
            let(angle = phi(theta) * 57.2958)
            1.95653 * pow(rf, 2) * pow(1.27689 * rf - 1, 2) * sin(angle);

        function r(rf,theta) = 
            let(angle = phi(theta) * 180 / PI)
            wave(theta) * (rf * sin(angle) + g(rf, theta) * cos(angle));

        sf = 1 + thickness;
        sections = [
            for(theta = [theta_from:theta_step:theta_to])
            let(
                path = [ 
                    for(rf = [0.1:rf_step:rf_to])
                    let(
                        r = r(rf,theta),
                        angle = theta * 57.2958, 
                        angle2 = phi(theta)* 57.2958,
                        x = r*sin(angle), 
                        y = r*cos(angle),
                        z = wave(theta)*(rf*cos(angle2)-g(rf,theta)*sin(angle2))
                    )
                    [x, y, z]
                ]
            )
            concat(
                [
                    for(p = path)
                    [p[0] * sf, p[1] * sf, p[2]] - [0, 0, thickness]
                ],
                reverse(path)
            )
        ];
        
        sweep(reverse(sections));
    }

    module draw(spirals) {    
        r = spirals[0][0] / 5;
        for(i = [0:len(spirals) - 1]) {
            rr = r * ((len(spirals) - sqrt(i == 0 || i == 1 ? .5 : i)) / len(spirals));
            path = spirals[i][1];
            
            polyline_join(path)
            rotate([45, 0, 0])
                sphere(rr, $fn = 4);
                
            
            center = spirals[i][2];
            
            for(i = [0:1]) {
                p = choose(path);
                
                v = (p - center);
                a = atan2(v.y, v.x);
                
                translate([each p, 0] + [0, 0, rr * 0.55])
                
                rotate([0, 15, a])
                rotate(a)
                scale(rr * 2.75) 
                union() {
                    rose(thickness, theta_from * 3 * r / rr, theta_to * r / rr, rf_to, rf_step);
                    translate([0, 0, .075])
                        sphere(.1);
                }
                }
        }
    }

    spirals = foliage_scroll([width, height], max_spirals, init_radius, min_radius);

    draw(spirals);
}
