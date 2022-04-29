module assertEqualPoint(expected, actual, epsilon = 0.0001) {
    leng_expected = len(expected);
    leng_actual = len(actual);

    assert(
        leng_expected == leng_actual,
        str("expected length: ", leng_expected, ", but: ", leng_actual)
    );

    assert(
        norm(expected - actual) <= epsilon,
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
