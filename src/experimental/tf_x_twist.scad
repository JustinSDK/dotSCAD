use <rotate_p.scad>;

/*
    size: The size of a rectangle.
    point: A point in the rectangle.
    angle: twisted angle.
*/
function tf_x_twist(size, point, angle) =
    let(
        xlen = size[0],
        ylen = size[1],
        y_offset = ylen / 2,
        a_step = angle / xlen,
        y_centered = [point[0], point[1], 0] + [0, -y_offset, 0]
    )
    rotate_p(y_centered, [point[0] * a_step, 0, 0]) + [0, y_offset, 0];