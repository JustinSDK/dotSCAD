use <in_polyline.scad>

module test_in_polyline() {
    echo("==== test_in_polyline ====");
    
    pts = [
        [0, 0],
        [10, 0],
        [10, 10]
    ];

    assert(!in_polyline(pts, [-2, -3]));  
    assert(in_polyline(pts, [5, 0]));   
    assert(in_polyline(pts, [10, 5]));   
    assert(!in_polyline(pts, [10, 15]));  

    pts2 = [
        [10, 0, 10],
        [20, 0, 10],
        [20, 10, 10]
    ]; 

    assert(in_polyline(pts2, [10, 0, 10])); 
    assert(in_polyline(pts2, [15, 0, 10])); 
    assert(!in_polyline(pts2, [15, 1, 10]));  
    assert(!in_polyline(pts2, [20, 11, 10]));           
}

test_in_polyline();