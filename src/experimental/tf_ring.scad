use <rotate_p.scad>;
use <experimental/tf_y_twist.scad>;

function tf_ring(size, point, radius, angle, twist = 0) = 
    let(
        yleng = size[1],
        a_step = angle / yleng,
        twisted = tf_y_twist(size, point, twist)
    )
    rotate_p([radius + twisted[0], 0, twisted[2]], a_step * twisted[1]);