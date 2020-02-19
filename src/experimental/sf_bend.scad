use <experimental/sf_solidify.scad>;
use <experimental/tf_bend.scad>;

/*
    levels : A list of numbers (0 ~ 255).
    radius: The radius of the arc after being bent
    thickness: shell thickness
    angle: The central angle of the arc..
    invert: inverts how the gray levels are translated into height values.
*/
module sf_bend(levels, radius, thickness, angle, invert = false) {
    rows = len(levels);
    columns = len(levels[0]);
    size = [columns - 1, rows - 1];

    surface1 = [
        for(r = [0:rows - 1]) 
        [
            for(c = [0:columns - 1]) 
            let(lv = invert ? 255 - levels[rows - r - 1][c] : levels[rows - r - 1][c])
            [c, r, lv / 255 * thickness]
        ]
    ];

    surface2 = [
        for(r = [0:rows - 1]) 
        [
            for(c = [0:columns - 1]) 
            [c, r, 0]
        ]
    ];

    offset_z = invert ? thickness : 0;
    sf_solidify(
        [
            for(row = surface1) 
            [
                for(p = row) 
                tf_bend(size, p, radius + offset_z, angle)
            ]
        ]
        ,
        [
            for(row = surface2) 
            [
                for(p = row) tf_bend(size, p, radius, angle)
            ]
        ]
    );
}