use <experimental/_impl/_sf_square_surfaces.scad>;
use <experimental/sf_solidify.scad>;

/*
    levels : A list of numbers (0 ~ 255).
    thickness: square thickness
    depth: the depth of the image
    invert: inverts how the gray levels are translated into height values.
*/
module sf_square(levels, thickness, depth, invert = false) {
    dp = is_undef(depth) ? thickness / 2 : depth;
    surface = _sf_square_surfaces(levels, thickness, dp, invert);
    offset_z = invert ? thickness : 0;

    sf_solidify(
        [
            for(row = surface[0]) 
            [
                for(p = row) p + [0, 0, offset_z]
            ]
        ],
        surface[1]
    );
}