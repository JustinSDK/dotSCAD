include <__private__/__m_multiply.scad>;
include <__private__/__m_shearing.scad>;

function m_shearing(sx = [0, 0], sy = [0, 0], sz = [0, 0]) = __m_shearing(sx, sy, sz);