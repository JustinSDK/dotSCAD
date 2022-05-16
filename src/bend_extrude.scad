/**
* bend_extrude.scad
*
* @copyright Justin Lin, 2019
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-bend_extrude.html
*
**/

module bend_extrude(size, thickness, angle, frags = 24) {
    x = size.x;
    y = size.y;
    frag_width = x / frags ;
    frag_angle = angle / frags;
    half_frag_width = 0.5 * frag_width;
    half_frag_angle = 0.5 * frag_angle;
    r = half_frag_width / sin(half_frag_angle);
    s =  (r - thickness) / r;
    
    scale = [s, 1];
    transX = [x, 0, 0];
    mirrorX = [1, 0, 0];
    sq_size = [frag_width, y];
    module get_frag(i) {
        offsetX = i * frag_width;
        linear_extrude(thickness, scale = scale) 
        translate([-offsetX - half_frag_width, 0, 0]) 
        intersection() {
            translate(transX) 
            mirror(mirrorX) 
                children();
            translate([offsetX, 0, 0]) 
                square(sq_size);
        }
    }

    offsetY = [0, -r * cos(half_frag_angle), 0];
    rotXn90 = [-90, 0, 0];

    rotate(angle - 90)
    mirror([0, 1, 0])
    mirror([0, 0, 1])
    for(i = [0 : frags - 1]) {
        rotate(i * frag_angle + half_frag_angle) 
        translate(offsetY)
        rotate(rotXn90) 
        get_frag(i) 
            children();  
    }
}
