use <rotate_p.scad>;

function tf_y_twist(size, point, angle) =
    let(
        xlen = size[0],
        ylen = size[1],
        x_offset = xlen / 2,
        a_step = angle / ylen,
        x_centered = [point[0], point[1], 0] + [-x_offset, 0, 0]
    )
    rotate_p(x_centered, [0, point[1] * a_step, 0]) + [x_offset, 0, 0];