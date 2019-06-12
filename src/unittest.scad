module assertEqualPoint(expected, actual, epsilon = 0.0001) {
    leng_expected = len(expected);
    leng_actual = len(actual);

    assert(
        leng_expected == leng_actual,
        str("expected length: ", leng_expected, ", but: ", leng_actual)
    );

    v_diff = expected - actual;
    v3d = len(v_diff) == 2 ? [v_diff[0], v_diff[1], 0] : v_diff; 

    assert(
        abs(v3d[0]) <= epsilon && abs(v3d[1]) <= epsilon && abs(v3d[2]) <= epsilon,
        str("expected: ", expected, ", but: ", actual)
    );
}

module assertEqualPoints(expected, actual, epsilon = 0.0001) {
    leng_expected = len(expected);
    leng_actual = len(actual);

    assert(
        leng_expected == leng_actual, 
        str("expected length: ", leng_expected, ", but: ", leng_actual)
    );

    for(i = [0:len(actual) - 1]) {        
        assertEqualPoint(expected[i], actual[i], epsilon);
    }
}

module assertEqualNum(expected, actual, epsilon = 0.0001) {
    assert(
        abs(expected - actual) <= epsilon, 
        str("expected: ", expected, ", but: ", actual)
    );
}
