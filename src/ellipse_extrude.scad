/**
* ellipse_extrude.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-ellipse_extrude.html
*
**/

module ellipse_extrude(semi_minor_axis, height, center = false, convexity = 10, twist = 0, slices = 20) {
    h = is_undef(height) ? semi_minor_axis : (
        // `semi_minor_axis` is always equal to or greater than `height`.
        height > semi_minor_axis ? semi_minor_axis : height
    );
    angle = asin(h / semi_minor_axis) / slices; 

    f_extrude = [
        for(i = 1; i <= slices; i = i + 1) 
        [
            cos(angle * i) / cos(angle * (i - 1)), 
            semi_minor_axis * sin(angle * i)
        ]
    ]; 
    len_f_extrude = len(f_extrude);

    accm_fs =
        [
            for(i = 0, pre_f = 1; i < len_f_extrude; pre_f = pre_f * f_extrude[i][0], i = i + 1)
                pre_f * f_extrude[i][0]
        ];

    child_fs = [1, each accm_fs];
    pre_zs = [0, each [for(i = 0; i < len_f_extrude; i = i + 1) f_extrude[i][1]]];

    module extrude() {
        for(i = [0:len_f_extrude - 1]) {
            f = f_extrude[i][0];
            z = f_extrude[i][1];

            translate([0, 0, pre_zs[i]]) 
            rotate(-twist / slices * i) 
            linear_extrude(
                z - pre_zs[i], 
                convexity = convexity,
                twist = twist / slices, 
                slices = 1,
                scale = f 
            ) 
            scale(child_fs[i]) 
                children();
        }
    }
    
    center_offset = [0, 0, center ? -h / 2 : 0];
    translate(center_offset) 
    extrude() 
        children();

    // hook for testing
    test_ellipse_extrude_fzc(child_fs, pre_zs, center_offset);
}

// override for testing
module test_ellipse_extrude_fzc(child_fs, pre_zs, center_offset) {

}