module bend_extrude(size, thickness, angle, frags = 24) {
    x = size[0];
    y = size[1];
    frag_width = x / frags ;
    frag_angle = angle / frags;
    half_frag_width = 0.5 * frag_width;
    half_frag_angle = 0.5 * frag_angle;
    r = half_frag_width / sin(half_frag_angle);
    s =  (r - thickness) / r;
    
    module get_frag(i) {
        offsetX = i * frag_width;
        linear_extrude(thickness, scale = [s, 1]) 
            translate([-offsetX - half_frag_width, 0, 0]) 
                intersection() {
                    children();
                    translate([offsetX, 0, 0]) 
                        square([frag_width, y]);
                }
    }

    offsetY = -r * cos(half_frag_angle) ;
    for(i = [0 : frags - 1]) {
       rotate(i * frag_angle + half_frag_angle) 
            translate([0, offsetY, 0])
                rotate([-90, 0, 0]) 
                    get_frag(i) 
                        children();  
    }

}
