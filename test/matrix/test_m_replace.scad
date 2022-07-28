use <matrix/m_replace.scad>

module test_m_replace() {
    echo("==== test_m_replace ====");

    original_m = [
        [1, 2, 3, 4],
        [5, 6, 7, 8],
        [9, 10, 11, 12]
    ];

    expected = [
        [1, 2, 3, 4],
        [5, 6, 70, 8],
        [9, 10, 11, 12]
    ];

    actual = m_replace(original_m, 1, 2, 70);

    assert(actual == expected);

}

test_m_replace();