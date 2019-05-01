include <__private__/__m_multiply.scad>;
include <__private__/__m_shearing.scad>;

module shear(sx = [0, 0], sy = [0, 0], sz = [0, 0]) {
    multmatrix(__m_shearing(sx, sy, sz)) children();
}