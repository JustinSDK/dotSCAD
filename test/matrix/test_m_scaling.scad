use <matrix/m_scaling.scad>

module test_m_scaling() {
    echo("==== test_m_scaling ====");

    expected = [[2, 0, 0, 0], [0, 1, 0, 0], [0, 0, 1, 0], [0, 0, 0, 1]];
    actual = m_scaling([2, 1, 1]);

    assert(expected == actual);
}

test_m_scaling();