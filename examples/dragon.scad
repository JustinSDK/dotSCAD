use <helix.scad>;
use <along_with.scad>;
use <shape_trapezium.scad>;
use <ellipse_extrude.scad>;

r1 = 25;
r2 = 15;
levels = 3;
level_dist = 20;

module scales(ang, leng, radius, height, thickness) {
    module one_scale() {
        rotate([0, ang, 0]) 
        linear_extrude(thickness, center = true) 
        scale([leng, 1]) 
            circle(1, $fn = 4);    
    }

    for(a = [0:30:330]) {
        rotate(a) 
        translate([radius, 0, height]) 
            one_scale();
            
        rotate(a + 15) 
        translate([radius, 0, height + 1.75]) 
            one_scale();
    }
}

module one_segment() {
    // scales
    scale([1,0.85,1]) union() {
        scales(60, 4, 5, 0, 1.5);
        scales(75, 2.5, 5, -4, 1.25);
        scales(100, 1.25, 4.5, -7, 1);
        scales(110, 1.25, 3, -9, 1);
        scales(120, 2.5, 2, -9, 1);   
    }
    
    // hair
    translate([0, 1, -4]) 
    rotate([45, 0, 0]) 
    rotate([0, 90, 0]) 
    linear_extrude(2, center = true) 
    scale([3.5, 2, 1]) 
        circle(3, $fn = 3);
            

    // belly
    translate([0, -3, 1]) 
    rotate([-10, 0, 0]) 
    scale([1.1, 0.8, 1.25])  
        sphere(5, $fn = 8); 
        
}

module head(angy_angz) {
    module hair() {
        for(i = [18:35]) {
            rotate(i * 10) 
            translate([0, -14, 0]) 
            rotate([9, 0, 0]) 
            linear_extrude(15, scale = 0, twist = 30) 
            translate([0, 10, 0]) 
                circle(3, $fn = 3);    
        }       

        for(i = [0:35]) {
            rotate(i * 10) 
            translate([0, -12, 0]) 
            rotate([5, 0, 0]) 
            linear_extrude(20, scale = 0, twist = 30) 
            translate([0, 10, 0]) 
                circle(2, $fn = 3);    
        }
        
        for(i = [0:35]) {
            rotate(i * 10) 
            translate([0, -10, 0]) 
            rotate([2, 0, 0]) 
            linear_extrude(22, scale = 0, twist = -30) 
            translate([0, 10, 0]) 
                circle(3, $fn = 3);    
        }     
    }
    
    module one_horn() {        
        translate([-10, -4, -1]) 
        rotate([40, -25, 0]) 
        linear_extrude(30, scale = 0, twist = -90) 
        translate([7.5, 0, 0]) 
            circle(3, $fn = 4);    
    }
    
    module mouth() {
        translate([0, 0, -2]) 
        rotate([90, 0, -90]) 
        ellipse_extrude(8, slices = 2) 
            polygon(
                shape_trapezium([4, 15], 
                h = 22,
                corner_r = 0)
            );       
        
        translate([0, 0, -3]) 
        rotate([90, 0, -90]) 
         ellipse_extrude(6, slices = 4) 
             polygon(
                shape_trapezium([6, 20], 
                h = 20,
                corner_r = 0)
            );    
                    
        mirror([1, 0, 0]) 
        translate([0, 0, -3]) 
        rotate([85, 0, -90])
        ellipse_extrude(4, slices = 2) 
            polygon(
                shape_trapezium([6, 19], 
                h = 20,
                corner_r = 0)
            );       
    }
    
    module one_eye() {
        translate([-5, 3, -2]) 
        rotate([-15, 0, 75]) 
        scale([1, 1, 1.5]) 
            sphere(1.5, $fn = 5);      

        translate([-5.5, 3.5, -2.5]) 
        rotate([-15, 0, 75]) 
            sphere(0.5, $fn = 12);                      
    }
    
    module one_beard() {
        translate([-11, -12, -11])
        rotate(180) 
        linear_extrude(10, scale = 0, twist = 90) 
        translate([-10, -10, 0]) 
            circle(0.75, $fn = 6);    
    }
    


    rotate([0, angy_angz[0] + 15, angy_angz[1]]) 
    translate([0, 0, -25 / 2]) 
    scale(1.15) {
       scale([0.8, 0.9, 1]) hair();

        translate([0, 0, 2]) {
            rotate(-90) {
                 one_horn();
                 mirror([-1, 0, 0]) one_horn();       
            }
            
            mouth();

            one_eye();
            mirror([0, 1, 0]) one_eye();
            
            one_beard();
            mirror([0, 1, 0]) one_beard();
        }        
    }
}

module dragon() {
    path_pts = helix(
        radius = [r1, r2], 
        levels = levels, 
        level_dist = level_dist, 
        vt_dir = "SPI_DOWN", 
        rt_dir = "CLK", 
        $fn = 36
    );

    function __angy_angz(p1, p2) = 
        let(
            dx = p2[0] - p1[0],
            dy = p2[1] - p1[1],
            dz = p2[2] - p1[2],
            ya = atan2(dz, sqrt(dx * dx + dy * dy)),
            za = atan2(dy, dx)
        ) [ya, za];
        
    angy_angz = __angy_angz(path_pts[0], path_pts[1]);
    
    
    scale(1.1) 
    along_with(path_pts, scale = 0.85, method = "EULER_ANGLE")    
        one_segment();
        
    translate([19, 0, 65]) 
    rotate([95, 0, 0]) 
    head(angy_angz);
}

translate([0, 0, 7]) dragon($fn = 12);
linear_extrude(65, scale = 0.4)  circle(30);
translate([0, 0, 65]) linear_extrude(15, scale = 0.01) circle(30 * 0.4);

