use <util/lerp.scad>

module test_lerp() {
    echo("==== test_lerp ====");
    
    assert(lerp([0, 0, 0], [100, 100, 100], 0.5) == [50, 50, 50]);  
}

test_lerp();
