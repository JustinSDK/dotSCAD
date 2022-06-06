use <line2d.scad>
use <hollow_out.scad>
use <bend_extrude.scad>

minute = 18; 
hour = 9;    
r = 30;
thickness = 2;
angle = 90;
frags = 24; 
xscale = 0.75;

module clock(r, thickness, hour, minute) {
    hollow_out(thickness) 
        circle(r);
    
    circle(thickness);
    
    rotate(-30 * hour - 0.5 * minute) 
        line2d([0, 0], [0, r - thickness * 6], thickness, p1Style = "CAP_ROUND", p2Style = "CAP_ROUND", $fn = 4);
    
    rotate(-6 * minute) 
        line2d([0, 0], [0, r - thickness * 3], thickness * 0.75, p1Style = "CAP_ROUND", p2Style = "CAP_ROUND", $fn = 4);  
 
    for(i = [0: 11]) {
        rotate(i * 30) 
        translate([0, r - thickness * 4, 0]) 
            square([thickness / 2, thickness * 2]);
    }
}

module melt(r, thickness, angle, frags, xscale = 1) {
    double_r = r * 2;
    half_r = r * 0.5;
    rz = r * 180 / (angle * 3.14159);

    mirror([0, 1, 0]) 
    scale([xscale, 1, 1]) 
    translate([0, r, rz])
    rotate([0, 90, -90]) 
    bend_extrude([r, double_r], thickness, angle, frags) 
    translate([0, r, 0]) 
        children(); 

    linear_extrude(thickness) 
        intersection() {
            translate([-half_r, 0, 0]) 
                square([r, double_r], center = true);
            children();
        }

}

module melted_clock() {

    $fn = 48;
    sa = r * angle / (r + thickness);
    rotate([0, 180, 0]) 
    mirror([1, 0, 0]) {
        color("Gold") 
        translate([0, 0, thickness]) 
        melt(r, thickness, angle, frags, xscale) 
            circle(r);
        
        color("Gainsboro") 
        melt(r, thickness, sa, frags, xscale) 
            clock(r - thickness * 2, thickness, hour, minute);
    }
}

melted_clock();