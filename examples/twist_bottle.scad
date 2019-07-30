include <hollow_out.scad>;
/* [Basic] */

shape = "Flower";  // [Flower, Circle]
model = "Outer"; // [Outer, Inner]
width = 30;
radius = 20;
height = 100;
thickness = 1;
spacing = 0.65;
twist = 180;

/* [Advanced] */

convexity = 10;
slices = 200;
   
module twist_bottle(model, height, thickness, twist, spacing, convexity, slices) {
    $fn = 96;
    
    module outer_container() {
        translate([0, 0, thickness])
            linear_extrude(height = height, twist = twist, convexity = convexity, slices = slices) 
                hollow_out(thickness) children();
                
        linear_extrude(thickness) 
            children();    
    }
    
    module inner_container() {
        linear_extrude(height = height, twist = twist, convexity = convexity, slices = slices) 
            hollow_out(thickness) 
                offset(r = -thickness - spacing) 
                    children();                
        
        translate([0, 0, height]) 
            rotate(twist) 
                linear_extrude(thickness) 
                    children();      
    }
    
    if(model == "Outer") {
        outer_container() 
            children();
    }
    else {
        translate([0, 0, height + thickness])
            rotate([180, 0, 0]) 
                inner_container() 
                    children();
    }
} 

if(shape == "Flower") {
    twist_bottle(model, height, thickness, twist, spacing, convexity, slices) union() {
        for(i = [0:3]) {
            rotate(90 * i) 
                translate([radius * 0.5, 0, 0]) 
                    circle(radius * 0.5);
        }
    }  
}

if(shape == "Circle") {
    twist_bottle(model, height, thickness, twist, spacing, convexity, slices) difference() {
        circle(radius);
        for(a = [0:120:240]) {
            rotate(a) 
                translate([radius, 0, 0]) 
                    circle(radius / 4);
        }
    }
}