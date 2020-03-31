use <ptf/ptf_x_twist.scad>;
use <ptf/ptf_y_twist.scad>;
use <surface/_impl/_sf_square_surfaces.scad>;
use <surface/sf_solidify.scad>;

module sf_square(levels, thickness, depth, x_twist = 0, y_twist = 0, invert = false) {
    size = [len(levels[0]), len(levels)];
    dp = is_undef(depth) ? thickness / 2 : depth;
    surface = _sf_square_surfaces(levels, thickness, dp, invert);
    offset_z = invert ? thickness : 0;

    sf_solidify(
        [
            for(row = surface[0]) [
                for(p = row) 
                    ptf_y_twist(size, 
                        ptf_x_twist(size, p + [0, 0, offset_z], x_twist), 
                        y_twist
                    )
            ]
        ],
        [
            for(row = surface[1]) [
                for(p = row) 
                    ptf_y_twist(size, 
                        ptf_x_twist(size, p, x_twist), 
                        y_twist
                    )
            ]
        ]
    );
}