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

function round_n(number, float_digits = 4) =
    let(n = pow(10, float_digits)) 
    round(number * n) / n;

function mul_round_pt(point, n) = 
    let(pt = point * n)
    len(pt) == 2 ? 
        [round(pt[0]), round(pt[1])] :
        [round(pt[0]), round(pt[1]), round(pt[2])];

function round_pts(points, float_digits = 4) = 
    let(n = pow(10, float_digits))
    [for(pt = points) mul_round_pt(pt, n) / n];

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
        n = pow(10, float_digits);

        shifted_expected = mul_round_pt(
            expected, n
        );

        shifted_actual = mul_round_pt(
            actual, n
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

module assertEqual(expected, actual, float_digits = 4) {
    r_expected = round_n(expected, float_digits);  
    r_actual = round_n(actual, float_digits);  

    if(r_expected != r_actual) {
        fail(
            "Equality", 
            str("expected: ", r_expected,
            ", but: ", r_actual)
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

module round_echo_pts(points, float_digits = 4) {
    echo(round_pts(points, float_digits = 4));
}

module round_echo_n(number, float_digits = 4) {
    echo(round_n(number, float_digits));
}