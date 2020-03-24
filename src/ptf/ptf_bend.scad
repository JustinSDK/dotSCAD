/*
    size: The size of the rectangle which can contain the point.
    point: A point in the rectangle.
    radius: The radius of the arc after being bent
    angle: The central angle of the arc.
*/

function ptf_bend(size, point, radius, angle) = 
    let(
        xlen = size[0],
        // ignored
        // ylen = size[1],
        y = point[0],
        z = point[1],
        x = is_undef(point[2]) ? 0 : point[2],
        a_step = angle / xlen,
        a = a_step * y,
        r = radius + x
    )
    [r * cos(a), r * sin(a), z];