use <util/slice.scad>

module test_slice() {
    echo("==== test_slice ====");

    lt = [for(c = "helloworld") c];
    expected1 = [for(c = "hello") c];
    expected2 = [for(c = "world") c];

    assert(expected1 == slice(lt, 0, 5)); 
    assert(expected2 == slice(lt, 5)); 
}

test_slice();