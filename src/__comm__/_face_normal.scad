use <../util/unit_vector.scad>

function _face_normal(points) = unit_vector(cross(points[2] - points[0], points[1] - points[0]));