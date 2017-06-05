module fail(title, message) {
    echo(
        str( 
            "<b>",
                "<span style='color: red'>", 
                    "FAIL: ",  title,
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
    let(pt = point * pow(10, digits))
    len(pt) == 2 ? 
        [round(pt[0]), round(pt[1])] :
        [round(pt[0]), round(pt[1]), round(pt[2])];

function round_pts(points, float_digits) = 
    [for(pt = points) shift_to_int(pt, float_digits) / pow(10, float_digits)];

module assertEqualPoint(expected, actual, float_digits = 4) {
    leng_expected = len(expected);
    leng_actual = len(actual);

    if(leng_expected != leng_actual) {
         fail(
            "Point", 
            str("expected length: ", leng_expected,
            ", but: ", leng_actual)
        );       
    } else {
        shifted_expected = shift_to_int(
            expected, float_digits
        );

        shifted_actual = shift_to_int(
            actual, float_digits
        );
        
        if(shifted_expected != shifted_actual) {
            fail(
                "Point", 
                str("expected: ", shifted_expected / n,
                ", but: ", shifted_actual / n)
            );
        }
    }
}

module assertEqualPoints(expected, actual, float_digits = 4) {
    leng_expected = len(expected);
    leng_actual = len(actual);

    if(leng_expected != leng_actual) {
         fail(
            "Points", 
            str("expected length: ", leng_expected,
            ", but: ", leng_actual)
        );       
    } else {
        for(i = [0:len(actual) - 1]) {        
            assertEqualPoint(expected[i], actual[i], float_digits);
        }
    }
}

module assertEqual(expected, actual) {        
    if(expected != actual) {
        fail(
            "Equality", 
            str("expected: ", expected,
            ", but: ", actual)
        );
    }
}

module assertTrue(truth) {        
    if(!truth) {
        fail(
            "Truth",
             "expected: true, but: false"
        );
    }
}