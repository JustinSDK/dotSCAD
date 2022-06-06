use <line3d.scad>

/* [Basic] */

stick_leng = 80;
stick_diameter = 5;
inner_square_leng = 60;
leng_diff = 1.75;
min_leng = 13;
stick_fn = 24;

/* [Advanced] */

cap_style = "CAP_CIRCLE"; // [CAP_BUTT, CAP_CIRCLE, CAP_SPHERE]
angle_offset = 5;
layer_offset = 1.2;

module stick_square(inner_square_leng, stick_leng, stick_diameter, cap_style) {
    diff_leng = stick_leng - inner_square_leng;
    half_inner_square_leng = inner_square_leng / 2;
    half_stick_leng = stick_leng / 2;
    
    module stick() {
        line3d(
            [0, -half_stick_leng, 0], 
            [0, half_stick_leng, 0], 
            stick_diameter,
            cap_style,
            cap_style
        );
    }

    module sticks() {
        translate([-half_inner_square_leng, 0, 0])
            stick();
        translate([half_inner_square_leng, 0, 0])
            stick();
    }

    sticks();
    translate([0, 0, stick_diameter]) 
    rotate(90) 
        sticks();
}
    
module spiral_stack(orig_leng, orig_height, current_leng, leng_diff, min_leng, angle_offset, pre_height = 0, i = 0) {
    if(current_leng > min_leng) {
        angle = atan2(leng_diff, current_leng - leng_diff);
        
        factor = current_leng / orig_leng;
        
        translate([0, 0, pre_height]) 
        scale(factor) 
            children();
         
        next_square_leng = sqrt(pow(leng_diff, 2) + pow(current_leng - leng_diff, 2));
        
        height = factor * orig_height + pre_height;
        
        rotate(angle + angle_offset)
            spiral_stack(
                orig_leng, 
                orig_height, 
                next_square_leng, 
                leng_diff, 
                min_leng,
                angle_offset,                
                height,
                i + 1
            ) children();
    } 
}

height = stick_diameter * layer_offset;
$fn = stick_fn;

spiral_stack(inner_square_leng, stick_diameter * 2, inner_square_leng, leng_diff, min_leng, angle_offset)
    stick_square(
        inner_square_leng, 
        stick_leng, 
        height, 
        cap_style
    );    