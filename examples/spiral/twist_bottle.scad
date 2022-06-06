use <box_extrude.scad>

/* [Basic] */

shape = "Heart";  // [Flower, Circle, Heart]
model = "Outer"; // [Outer, Inner]
width = 30;
radius = 20;
height = 100;
thickness = 1;
spacing = 0.65;
twist = 180;

/* [Advanced] */

slices = 200;
   
module twist_bottle(model, height, thickness, twist, spacing, slices) {
    $fn = 48;
    
    module bottle() {
        box_extrude(height = height + thickness, shell_thickness = thickness, twist = twist, slices = slices)
            children(); 
    }
    
    module inner_container() {
        bottle()
        offset(r = -thickness - spacing)     
            children();

        linear_extrude(thickness) 
            children();          
    }
    
    if(model == "Outer") {
        bottle() 
            children();
    } else if(model == "Inner") {
        inner_container() 
            children();      
    }
} 

module heart(radius, center = false) {
    sin45 = sin(45);
    cos45 = cos(45);
    
    module heart_sub_component(radius) {
        diameter = radius * 2;
        $fn = 48;

        translate([-radius * cos45, 0, 0]) 
        rotate(-45) {
            circle(radius);
            translate([0, -radius, 0]) 
                square(diameter);
        }
    }
    
    
    offsetX = center ? 0 : radius + radius * cos(45);
    offsetY = center ? 1.5 * radius * sin45 - 0.5 * radius : 3 * radius * sin45;

    translate([offsetX, offsetY, 0]) {
        heart_sub_component(radius);
        mirror([1, 0, 0]) heart_sub_component(radius);
    }
}

if(shape == "Flower") {
    twist_bottle(model, height, thickness, twist, spacing, slices) 
    union() {
        for(i = [0:3]) {
            rotate(90 * i) 
            translate([radius * 0.5, 0, 0]) 
                circle(radius * 0.5);
        }
    }  
} else if(shape == "Circle") {
    twist_bottle(model, height, thickness, twist, spacing, slices) 
    difference() {
        circle(radius);
        union() {
            for(a = [0:120:240]) {
                rotate(a) 
                translate([radius, 0, 0]) 
                    circle(radius / 4);
            }
        }
    }
} else if(shape == "Heart") {
    twist_bottle(model, height, thickness, twist, spacing, slices) 
        heart(radius * 1.9 / (3 * sin(45) + 1), center = true);
}

