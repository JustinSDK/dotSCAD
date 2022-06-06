use <box_extrude.scad>
use <part/joint_T.scad>
use <triangle2square.scad>

tri_side_leng = 100;
height = 30;
spacing = 0.4;
ring_width = 1.5;  
shaft_r = 1;  
    
module triangle2square_box(type, tri_side_leng, height, spacing, ring_width, shaft_r) {
	half_tri_side_leng = tri_side_leng / 2;
    half_h = height / 2;

    joint_ring_inner = shaft_r + spacing;
	joint_r_outermost = joint_ring_inner + ring_width + spacing;

    offsetd = -spacing / 2;
    tri_sq = triangle2square(tri_side_leng);
    
    module 2d_tri_square() {
        difference() {
            offset(offsetd) polygon(tri_sq[0][0]);
            translate(tri_sq[1][2]) circle(joint_r_outermost);
        }
        difference() {
            offset(offsetd) polygon(tri_sq[0][1]);
            translate(tri_sq[1][0]) circle(joint_ring_inner);
        }
        
        difference() {
            offset(offsetd) polygon(tri_sq[0][2]);
            translate(tri_sq[1][0]) circle(joint_r_outermost);
            translate(tri_sq[1][1]) circle(joint_ring_inner);
        }
        
        difference() {
            offset(offsetd) polygon(tri_sq[0][3]);
            translate(tri_sq[1][2]) circle(joint_ring_inner);
            translate(tri_sq[1][1]) circle(joint_r_outermost);
        }
    }
    
    if(type == "CONTAINER") {
        box_extrude(height = height, shell_thickness = ring_width) 
            2d_tri_square();
        
        translate(tri_sq[1][0]) rotate(65) joint_T(shaft_r, height, joint_r_outermost, ring_width, spacing);
        translate(tri_sq[1][1]) rotate(170) joint_T(shaft_r, height, joint_r_outermost, ring_width, spacing);
        translate(tri_sq[1][2]) rotate(275) joint_T(shaft_r, height, joint_r_outermost, ring_width, spacing);    
    }
    else if(type == "COVER") {
        box_extrude(height = ring_width * 2, shell_thickness = ring_width)  
        mirror([1, 0, 0]) 
            offset(-ring_width - spacing) 2d_tri_square();

        linear_extrude(ring_width) 
        mirror([1, 0, 0]) 
            2d_tri_square();
    }
}


$fn = 36;
triangle2square_box("CONTAINER", tri_side_leng, height, spacing, ring_width, shaft_r);
triangle2square_box("COVER", tri_side_leng, height, spacing, ring_width, shaft_r);

