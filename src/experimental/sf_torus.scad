use <experimental/_impl/_sf_square_surfaces.scad>;
use <experimental/sf_solidify.scad>;
use <experimental/ptf_torus.scad>;

/*
    levels : A list of numbers (0 ~ 255).
    radius: torus [R, r]
    thickness: shell thickness
    depth: the depth of the image
    angle: torus [A, a].
    twist: The number of degrees of through which the rectangle is twisted.
    invert: inverts how the gray levels are translated into height values.
*/
module sf_torus(levels, radius, thickness, depth, angle = [360, 360], twist = 0, invert = false) {
    dp = is_undef(depth) ? thickness / 2 : depth;
    surface = _sf_square_surfaces(levels, thickness, dp, invert);
    rows = len(levels);
    columns = len(levels[0]);
    size = [columns - 1, rows - 1];

    R = radius[0];
    r = radius[1];

    offset_z = invert ? thickness : 0;

    tr1 = [R, r + offset_z];
    tr2 = [R + thickness, r];

    sf_solidify(
        [
            for(row = surface[0]) 
            [
                for(p = row) ptf_torus(size, p, tr1, angle, twist)
            ]
        ],
        [
            for(row = surface[1]) 
            [
                for(p = row) ptf_torus(size, p, tr2, angle, twist)
            ]
        ]
    );
}