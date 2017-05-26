module fail(message) {
    echo(
        str( 
            "<b>",
                "<span style='color: red'>", 
                    "FAIL", 
                "</span>", 
            "</b>"
        )
    );
    if(message != undef) {
        echo(
            str( 
                "<b>",
                    "<span style='color: red'>　",
                        message, 
                    "</span>", 
                "</b>"
            )
        );
    }
}

function shift_to_int(point, digits) = 
    let(
        pt = point * digits
    )
    len(pt) == 2 ? 
        [round(pt[0]), round(pt[1])] :
        [round(pt[0]), round(pt[1]), round(pt[2])];

function all_shift_to_int(points, digits) = 
    [for(pt = points) shift_to_int(pt, digits) / digits];

module assertEqualPoint(expected, actual) {
    n = 10000;

    shifted_expected = shift_to_int(
        expected, n
    );

    shifted_actual = shift_to_int(
        actual, n
    );
    
    if(shifted_expected != shifted_actual) {
        fail(
            str("expected: ", shifted_expected / n,
            ", but: ", shifted_actual / n)
        );
    }
}

module assertEqualPoints(expected, actual) {
    for(i = [0:len(actual) - 1]) {        
        assertEqualPoint(expected[i], actual[i]);
    }
}