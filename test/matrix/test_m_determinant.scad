use <matrix/m_determinant.scad>

module test_m_determinant() {
    echo("==== test_m_determinant ====");

    assert(
        m_determinant([
            [3, 8],
            [4, 6]
        ]) == -14
    );

    assert(
        m_determinant([
            [6,  1, 1],
            [4, -2, 5],
            [2,  8, 7]
        ]) == -306
    );

    assert(
        m_determinant([
            [0,  4, 0, -3],
            [1,  1, 5,  2],
            [1, -2, 0,  6],
            [3,  0, 0,  1]
        ]) == -250
    );
}

test_m_determinant();