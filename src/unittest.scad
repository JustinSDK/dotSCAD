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

module assertEqualPoint(expected, actual, epsilon = 0.0001) {
    leng_expected = len(expected);
    leng_actual = len(actual);

    if(leng_expected != leng_actual) {
         fail(
            "Point", 
            str("expected length: ", leng_expected,
            ", but: ", leng_actual)
        );       
    } else {
        for(elem = (expected - actual)) {
            if(abs(elem) > epsilon) {
                fail(
                    "Point", 
                    str("expected: ", expected,
                    ", but: ", actual)
                );
            }
        }
    }
}

module assertEqualPoints(expected, actual, epsilon = 0.0001) {
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
            assertEqualPoint(expected[i], actual[i], epsilon);
        }
    }
}

module assertEqualNum(expected, actual, epsilon = 0.0001) {
    if(abs(expected - actual) > epsilon) {
        fail(
            "Equality", 
            str("expected: ", expected,
            ", but: ", actual)
        );
    }
}

function mul_round_vector(vector, n) = 
    let(vt = vector * n)
    [for(v = vt) round(v)]; 

function round_vectors(vectors, float_digits = 4) = 
    let(n = pow(10, float_digits))
    [for(vt = vectors) mul_round_vector(vt, n) / n];

