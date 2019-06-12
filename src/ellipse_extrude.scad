/**
* ellipse_extrude.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-ellipse_extrude.html
*
**/

module ellipse_extrude(semi_minor_axis, height, center = false, convexity = 10, twist = 0, slices = 20) {
    h = is_undef(height) ? semi_minor_axis : (
        // `semi_minor_axis` is always equal to or greater than `height`.
        height > semi_minor_axis ? semi_minor_axis : height
    );
    angle = asin(h / semi_minor_axis) / slices; 

    function f_extrude(i = 1) = 
        i <= slices ? 
            concat(
                [
                    [
                        cos(angle * i) / cos(angle * (i - 1)), 
                        semi_minor_axis * sin(angle * i)
                    ]
                ],
                f_extrude(i + 1)
            ) : []; 

    fzs = f_extrude(); 
    len_fzs = len(fzs);

    function accm_fs(pre_f = 1, i = 0) =
        i < len_fzs ? 
            concat(
                [pre_f * fzs[i][0]],
                accm_fs(pre_f * fzs[i][0], i + 1)
            ) : [];
    
    child_fs = concat([1], accm_fs());
    pre_zs = concat(
        [0],
        [
            for(i = 0; i < len_fzs; i = i + 1)
                fzs[i][1]
        ]
    );

    module extrude() {
        for(i = [0:len_fzs - 1]) {
            f = fzs[i][0];
            z = fzs[i][1];

            translate([0, 0, pre_zs[i]]) 
                rotate(-twist / slices * i) 
                    linear_extrude(
                        z - pre_zs[i], 
                        convexity = convexity,
                        twist = twist / slices, 
                        slices = 1,
                        scale = f 
                    ) scale(child_fs[i]) children();
        }
    }
    
    center_offset = [0, 0, center == true ? -h / 2 : 0];
    translate(center_offset) 
        extrude() 
            children();

    // hook for testing
    test_ellipse_extrude_fzc(child_fs, pre_zs, center_offset);
}

// override for testing
module test_ellipse_extrude_fzc(child_fs, pre_zs, center_offset) {

}