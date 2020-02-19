use <experimental/_impl/_sf_square_surfaces.scad>;
use <experimental/sf_solidify.scad>;
use <experimental/tf_ring.scad>;

/*
    levels : A list of numbers (0 ~ 255).
    radius: ring radius.
    thickness: thickness
    angle: arc angle.
    invert: inverts how the gray levels are translated into height values.
*/

module sf_ring(levels, radius, thickness, angle = 360, invert = false) {
    surface = _sf_square_surfaces(levels, thickness, invert);
    rows = len(levels);
    columns = len(levels[0]);
    size = [columns - 1, rows - 1];
    
    offset_z = invert ? thickness : 0;
    sf_solidify(
        [
            for(row = surface[0]) 
            [
                for(p = row) 
                    tf_ring(size, p, radius, angle, 0) + + [0, 0, offset_z]
            ]
        ],
        [
            for(row = surface[1]) 
            [
                for(p = row) 
                    tf_ring(size, p, radius, angle, 0)
            ]
        ]
    );
}