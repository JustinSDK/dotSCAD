use <experimental/sf_solidify.scad>;

/*
    levels : A list of numbers (0 ~ 255).
    thickness: square thickness
    invert: inverts how the gray levels are translated into height values.
*/
module sf_square(levels, thickness, invert = false) {
    rows = len(levels);
    columns = len(levels[0]);
    offset_z = invert ? thickness : 0;
    size = [columns - 1, rows - 1];

    sf_solidify(
        [
            for(r = [0:rows - 1]) 
            [
                for(c = [0:columns - 1]) 
                let(lv = invert ? 255 - levels[rows - r - 1][c] : levels[rows - r - 1][c])
                [c, r, lv / 255 * thickness + offset_z]
            ]
        ],
         [
            for(r = [0:rows - 1]) 
            [
                for(c = [0:columns - 1]) 
                [c, r, 0]
            ]
        ]     
    );
}