/**
* rounded_extrude.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-rounded_extrude.html
*
**/

use <__comm__/__frags.scad>

module rounded_extrude(size, round_r, angle = 90, twist = 0, convexity = 10) {
    is_flt = is_num(size);
    x = is_flt ? size : size.x;
    y = is_flt ? size : size.y;
    
    q_corner_frags = __frags(round_r) / 4;
    
    step_a = angle / q_corner_frags;
    twist_step = twist / q_corner_frags;

    module layers(pre_x, pre_y, pre_h = 0, i = 1) {
        module one_layer(current_a) {
            wx = pre_x;    
            wy = pre_y;
            
            h = (round_r - pre_h) - round_r * cos(current_a);
            
            d_leng = round_r * (sin(current_a) - sin(step_a * (i - 1)));
            
            sx = (d_leng * 2 + wx) / wx;
            sy = (d_leng * 2 + wy) / wy;

            translate([0, 0, pre_h]) 
            rotate(-twist_step * (i - 1)) 
            linear_extrude(
                h, 
                slices = 1, 
                scale = [sx, sy], 
                convexity = convexity, 
                twist = twist_step
            ) 
            scale([wx / x, wy / y]) 
                children();     

            test_rounded_extrude_data(i, wx, wy, pre_h, sx, sy);

            layers(wx * sx, wy * sy, h + pre_h, i + 1)
                children();   
                    
        }    
    
        if(i <= q_corner_frags) {
            one_layer(i * step_a) 
                children();
        } else if(i - q_corner_frags < 1) {
            one_layer(q_corner_frags * step_a) 
                children();
        }
    }
    
    layers(x, y) 
        children();
}

module test_rounded_extrude_data(i, wx, wy, pre_h, sx, sy) {

}