use <hollow_out.scad>

model = "ALL"; // [JOIN, RING, ALL]
radius = 131.3 / 2;
width = 4;
height = 2.5;
layer_h = 12.5;
layers = 21;

module lamp_layer(radius, width, height) {
    linear_extrude(height, center = true)
    hollow_out(width)
        circle(radius + width, $fn = 6);
}

module join(radius, width, height, layer_h, layer_hoff = 0.95) {
    layer_a = 5;
    difference() {
        translate([radius - width / 2, 0, 0])
        rotate(5) {
            linear_extrude(height * 2, center = true)
                square(width * 1.25 * 1.49, center = true);
                
            translate([-width * 1.25 * 1.49 / 4, width * .85, 0])
            linear_extrude(layer_h)
                square([width * 1.25 / 2 * 1.49, width * 1.5], center = true);
                
            translate([0, width * 1.6, layer_h])
            linear_extrude(height * 2, center = true)
                square(width * 1.25 * 1.49, center = true);
        }
        
        for(i = [0:1]) {
            translate([0, 0, layer_h * i])
            rotate(layer_a * i)
                 lamp_layer(r_circumscribed_circle, width, height * layer_hoff);
        }
    }
}


r_circumscribed_circle = radius / cos(30);

if(model == "JOIN") {
    color("white")
    rotate(-5)
    translate([-(r_circumscribed_circle - width / 2), 0, 0])
        join(r_circumscribed_circle, width, height, layer_h);
}
else if(model == "RING") {
    color("black")
    lamp_layer(r_circumscribed_circle, width, height);
}
else {
    layer_a = 5;    
    n = layers - 1;

    color("black") {
        for(i = [0:2]) {
            rotate(i * 120)
                join(r_circumscribed_circle, width, height, layer_h);
        }

        translate([0, 0, layer_h])
        rotate(65)
        for(i = [0:2]) {
            rotate(i * 120)
                join(r_circumscribed_circle, width, height, layer_h);
        }
    }

    color("white") 
    for(h = [0:2:n - 2]) {
        translate([0, 0, layer_h * h]) 
        rotate(h * 5) {
            for(i = [0:2]) {
                rotate(i * 120)
                    join(r_circumscribed_circle, width, height, layer_h);
            }

            translate([0, 0, layer_h])
            rotate(65)
            for(i = [0:2]) {
                rotate(i * 120)
                    join(r_circumscribed_circle, width, height, layer_h);
            }
        }
    }
        
    color("black")
    for(i = [0:n]) {
        translate([0, 0, layer_h * i])
        rotate(layer_a * i)
             lamp_layer(r_circumscribed_circle, width, height);
    }
}