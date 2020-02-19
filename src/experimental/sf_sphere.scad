use <experimental/_impl/_sf_square_surfaces.scad>;
use <experimental/sf_solidify.scad>;
use <experimental/tf_sphere.scad>;

/*
    levels : A list of numbers (0 ~ 255).
    radius: sphere radius.
    thickness: shell thickness
    angle: [za, xa] mapping angles.
    invert: inverts how the gray levels are translated into height values.
*/
module sf_sphere(levels, radius, thickness, angle = [180, 360], invert = false) {
    surface = _sf_square_surfaces(levels, thickness, invert);
    rows = len(levels);
    columns = len(levels[0]);
    size = [columns - 1, rows - 1];

    offset_z = invert ? thickness : 0;
    sf_solidify(
        [
            for(row = surface[0]) 
            [
                for(p = row) tf_sphere(size, p, radius + offset_z, angle)
            ]
        ]
        ,
        [
            for(row = surface[1]) 
            [
                for(p = row) tf_sphere(size, p, radius, angle)
            ]
        ]
    );
}