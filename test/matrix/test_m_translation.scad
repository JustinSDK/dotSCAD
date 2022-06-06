use <matrix/m_translation.scad>

module test_m_translation() {
    echo("==== test_m_translation ====");

    expected = [[1, 0, 0, 10], [0, 1, 0, 20], [0, 0, 1, 0], [0, 0, 0, 1]];
    actual = m_translation([10, 20, 0]);
    
    assert(expected == actual);
}

test_m_translation();