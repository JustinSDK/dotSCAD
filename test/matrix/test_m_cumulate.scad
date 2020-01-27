use <unittest.scad>;
use <matrix/m_rotation.scad>;
use <matrix/m_scaling.scad>;
use <matrix/m_translation.scad>;
use <matrix/m_cumulate.scad>;

module test_m_cumulate() {
    echo("==== test_m_cumulate ====");

    expected = [[1, -1.73205, 0, 10], [1.73205, 1, 0, 20], [0, 0, 2, 10], [0, 0, 0, 1]];
    actual = m_cumulate([
        m_translation([10, 20, 10]), m_scaling(2), m_rotation(60)]
    );
    
    assertEqualPoints(expected, actual);
}

test_m_cumulate();