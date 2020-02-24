use <experimental/_impl/_sf_square_surfaces.scad>;
use <experimental/sf_solidify.scad>;
use <experimental/ptf_bend.scad>;

/*
    levels : A list of numbers (0 ~ 255).
    radius: The radius of the arc after being bent
    thickness: shell thickness
    depth: the depth of the image
    angle: The central angle of the arc..
    invert: inverts how the gray levels are translated into height values.
*/
module sf_bend(levels, radius, thickness, depth, angle = 180, invert = false) {
    dp = is_undef(depth) ? thickness / 2 : depth;
    surface = _sf_square_surfaces(levels, thickness, dp, invert);
    rows = len(levels);
    columns = len(levels[0]);
    size = [columns - 1, rows - 1];

    offset_z = invert ? thickness : 0;
    r = radius + offset_z;
    sf_solidify(
        [
            for(row = surface[0]) 
            [
                for(p = row) ptf_bend(size, p, r, angle)
            ]
        ],
        [
            for(row = surface[1]) 
            [
                for(p = row) ptf_bend(size, p, radius, angle)
            ]
        ]
    );
}