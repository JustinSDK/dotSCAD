include <line2d.scad>;
include <turtle/turtle2d.scad>;

module triangle(t, side_leng, width) {    
    $fn = 48;
    angle = 120; 
    t_p1 = turtle2d("forward", t, side_leng);          
    line2d(
        turtle2d("pt", t), turtle2d("pt", t_p1), 
        width, p1Style = "CAP_ROUND", p2Style =  "CAP_ROUND"
    );    

    t_p2 = turtle2d("forward", turtle2d("turn", t_p1, angle), side_leng);  
    line2d(
        turtle2d("pt", t_p1), turtle2d("pt", t_p2), 
        width, p1Style = "CAP_ROUND", p2Style =  "CAP_ROUND"
    ); 

    t_p3 = turtle2d("forward", turtle2d("turn", t_p2, angle), side_leng);   
    line2d(
        turtle2d("pt", t_p2), turtle2d("pt", t_p3), 
        width, p1Style = "CAP_ROUND", p2Style =  "CAP_ROUND"
    );  
}

module two_triangles(t, side_len, len_limit, width) {
    angle = 60;
    triangle(t, side_len, width);
    next_t = turtle2d("turn", turtle2d("forward", t, side_len / 2), angle); 
    triangle(next_t, side_len / 2, width);
}

module sierpinski_triangle(t, side_len, len_limit, width) {
    if(side_len >= len_limit) {
        two_triangles(t, side_len, len_limit, width);

        sierpinski_triangle(t, side_len / 2, len_limit, width);

        sierpinski_triangle(
            turtle2d("forward", t, side_len / 2), 
            side_len / 2, len_limit, width
        );

        sierpinski_triangle(
            turtle2d("turn", turtle2d("forward", turtle2d("turn", t, 60), side_len / 2), -60), 
            side_len / 2, len_limit, width
        );
    }
}

side_len = 150;
len_limit = 4;
width = 0.5;
t = turtle2d("create", 0, 0, 0);

sierpinski_triangle(t, side_len, len_limit, width);