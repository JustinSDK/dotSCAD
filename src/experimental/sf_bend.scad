use <experimental/_impl/_sf_square_surfaces.scad>;
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
    surface = _sf_square_surfaces(levels, thickness, invert);
    rows = len(levels);
    columns = len(levels[0]);
    size = [columns - 1, rows - 1];

    offset_z = invert ? thickness : 0;
    r = radius + offset_z;
    sf_solidify(
        [
            for(row = surface[0]) 
            [
                for(p = row) tf_bend(size, p, r, angle)
            ]
        ],
        [
            for(row = surface[1]) 
            [
                for(p = row) tf_bend(size, p, radius, angle)
            ]
        ]
    );
}