use <arc.scad>
use <pie.scad>
use <polyline2d.scad>

ball_radius = 15;
thickness = 2.5;
magnet_radius = 3.2;
magnet_height = 1.5;

emoticon(ball_radius, magnet_radius, magnet_height, thickness)
    grinning_face_with_smiling_eyes(ball_radius);
    
translate([ball_radius * 2.5, 0, 0])
emoticon(ball_radius, magnet_radius, magnet_height, thickness)
    grinning_squinting_face(ball_radius);
    
translate([ball_radius * 5, 0, 0])
emoticon(ball_radius, magnet_radius, magnet_height, thickness)
    persevering_face(ball_radius);

translate([ball_radius * 7.5, 0, 0])    
emoticon(ball_radius, magnet_radius, magnet_height, thickness)
    smirking_face(ball_radius);

module emoticon(ball_radius, magnet_radius, magnet_height, thickness) {
    $fn = 64;
    difference() {
        sphere(ball_radius);
        sphere(ball_radius - thickness);
        
        translate([0, 0, -ball_radius])
        linear_extrude(magnet_height)
            circle(magnet_radius);
        
        translate([0, 0, ball_radius])
        mirror([0, 0, 1])
        linear_extrude(ball_radius * 1.1, scale = 0.5)
            children();
    }
}

// design your emoticon in a cirle with a radius of `ball_radius`.

module grinning_face_with_smiling_eyes(ball_radius) {
    translate([ball_radius / 2.25, ball_radius / 8, 0]) 
        arc(ball_radius / 4, 180, width = ball_radius / 10);

    translate([-ball_radius / 2.25, ball_radius / 8, 0]) 
        arc(ball_radius / 4, 180, width = ball_radius / 10);

    scale([1, 0.8, 1])
    translate([0, -ball_radius / 3, 0]) 
        pie(radius = ball_radius / 1.5, angle = [180, 360]);   
}

module grinning_squinting_face(ball_radius) {
    r = ball_radius * 0.4;
    a = 25;
    
    translate([ball_radius / 4, ball_radius / 4, 0]) 
        polyline2d([[r * cos(a), r * sin(a)], [0, 0], [r * cos(a), r * -sin(a)]], width = ball_radius / 10);

    translate([-ball_radius / 4, ball_radius / 4, 0]) 
        polyline2d([[-r * cos(a), r * sin(a)], [0, 0], [-r * cos(a), r * -sin(a)]], width = ball_radius / 10);

    scale([1, 0.8, 1])
    translate([0, -ball_radius / 3, 0]) 
        pie(radius = ball_radius / 1.5, angle = [180, 360]);   
}

module persevering_face(ball_radius) {
    r = ball_radius * 0.4;
    a = 25;
    
    translate([ball_radius / 4, ball_radius / 4, 0]) 
        polyline2d([[r * cos(a), r * sin(a)], [0, 0], [r * cos(a), r * -sin(a)]], width = ball_radius / 10);

    translate([-ball_radius / 4, ball_radius / 4, 0]) 
        polyline2d([[-r * cos(a), r * sin(a)], [0, 0], [-r * cos(a), r * -sin(a)]], width = ball_radius / 10);

    scale([1.4, 0.8, 1])
    translate([0, -ball_radius / 1.75, 0]) 
        arc(ball_radius / 4, 180, width = ball_radius / 10);
}

module smirking_face(ball_radius) {
    r = ball_radius * 0.4;
    a = 25;
    
    translate([ball_radius / 2.5, ball_radius / 25, 0]) {
        //scale([1, 0.9, 1])
        arc(ball_radius / 3, [35, 150], width = ball_radius / 10);
        translate([ball_radius / 6, ball_radius / 5.5 ,0])
            circle(ball_radius / 8);
    }
    
    translate([-ball_radius / 2, ball_radius / 25, 0]) {
        //scale([1, 0.9, 1])
        arc(ball_radius / 3, [35, 150], width = ball_radius / 10);
        translate([ball_radius / 6, ball_radius / 5.5 ,0])
            circle(ball_radius / 8);
    }

    scale([1.3, 1, 1])
    translate([-ball_radius / 15, -ball_radius / 6, 0]) 
        arc(ball_radius / 3, [235, 350], width = ball_radius / 10);
}

