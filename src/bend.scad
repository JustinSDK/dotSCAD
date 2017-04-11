/**
* bend.scad
*
* Bends a 3D object into an arc shape. 
* 
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-bend.html
*
**/ 


module bend(size, angle, frags = 24) {
    x = size[0];
    y = size[1];
    z = size[2];
    frag_width = x / frags;
    frag_angle = angle / frags;
    half_frag_width = 0.5 * frag_width;
    half_frag_angle = 0.5 * frag_angle;
    r = half_frag_width / sin(half_frag_angle);
    h = r * cos(half_frag_angle);
    
    module triangle_frag() {
        translate([0, -z, 0]) 
            linear_extrude(y) 
                polygon(
                    [
                        [0, 0], 
                        [half_frag_width, h], 
                        [frag_width, 0], 
                        [0, 0]
                    ]
                );    
    }
    
    module get_frag(i) {
        translate([-frag_width * i - half_frag_width, -h + z, 0]) 
            intersection() {
                translate([frag_width * i, 0, 0]) 
                    triangle_frag();
                rotate([90, 0, 0]) 
                    children();
            }
    }

    for(i = [0 : frags - 1]) {
        rotate(i * frag_angle + half_frag_angle) 
            get_frag(i) 
                children();  
    }
}