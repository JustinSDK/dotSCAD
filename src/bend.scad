/**
* bend.scad
* 
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-bend.html
*
**/ 


module bend(size, angle, frags = 24) {
    x = size.x;
    y = size.y;
    z = size.z;
    frag_width = x / frags;
    frag_angle = angle / frags;
    half_frag_width = 0.5 * frag_width;
    half_frag_angle = 0.5 * frag_angle;
    r = half_frag_width / sin(half_frag_angle);
    h = r * cos(half_frag_angle);
    
    tri_frag_pts = [
        [0, 0], 
        [half_frag_width, h], 
        [frag_width, 0], 
        [0, 0]
    ];

    module triangle_frag() {
        translate([0, -z, 0]) 
        linear_extrude(y) 
            polygon(tri_frag_pts);    
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

    rotate(90) for(i = [0 : frags - 1]) {
        rotate(i * frag_angle + half_frag_angle) 
        get_frag(i) 
            children();  
    }

    // hook for testing
    test_bend_tri_frag(tri_frag_pts, frag_angle);
}

// override it to test
module test_bend_tri_frag(points, angle) {

}