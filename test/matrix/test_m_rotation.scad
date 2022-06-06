use <unittest.scad>
use <matrix/m_rotation.scad>

module test_m_rotation() {
    echo("==== test_m_rotation ====");

    a = [0, -45, 45];

    expected = [[0.5, -0.707107, -0.5, 0], [0.5, 0.707107, -0.5, 0], [0.707107, 0, 0.707107, 0], [0, 0, 0, 1]];
    actual = m_rotation(a);
    assertEqualPoints(expected, actual, 0.0005);

    v = [10, 10, 10];

    expected2 = [[0.804738, -0.310617, 0.505879, 0], [0.505879, 0.804738, -0.310617, 0], [-0.310617, 0.505879, 0.804738, 0], [0, 0, 0, 1]];
    actual2 = m_rotation(a = 45, v = v);

    assertEqualPoints(expected2, actual2, 0.0005);
}

test_m_rotation();