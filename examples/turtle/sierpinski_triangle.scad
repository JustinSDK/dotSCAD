include <line2d.scad>;
include <polyline2d.scad>;
include <turtle/turtle2d.scad>;

side_len = 100;
min_len = 4;
thickness = 0.5; 

sierpinski_triangle(
    turtle2d("create", 0, 0, 0), 
    side_len, min_len, thickness, $fn = 12
);

module triangle(t, side_leng, thickness) {    
    t2 = turtle2d("forward", t, side_leng);   
    t3 = turtle2d("forward", turtle2d("turn", t2, 120), side_leng);  

    polyline2d([
        turtle2d("pt", t),
        turtle2d("pt", t2),
        turtle2d("pt", t3),
        turtle2d("pt", t)
    ], thickness, startingStyle = "CAP_ROUND", endingStyle =  "CAP_ROUND");
}

module sierpinski_triangle(t, side_len, min_len, thickness) {
    triangle(t, side_len, thickness);

    if(side_len >= min_len) {
        half_len = side_len / 2;
        t2 = turtle2d("forward", t, half_len);
        t3 = turtle2d("turn", turtle2d("forward", turtle2d("turn", t, 60), half_len), -60);
        for(turtle = [t, t2, t3]) {
            sierpinski_triangle(turtle, half_len, min_len, thickness);
        }
        sierpinski_triangle(t3, half_len, min_len, thickness);
    }
}