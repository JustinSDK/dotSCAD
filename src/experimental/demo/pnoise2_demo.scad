use <util/rand.scad>;
use <function_grapher.scad>;
use <experimental/pnoise2.scad>;

module demo1() {
    points = [
        for(y = [0:.2:10])
            for(x = [0:.2:10])
                [x, y]
    ];
    noise = pnoise2(points);
    
    for(i = [0:len(points) - 1]) {
        c = (noise[i] + 1.1) / 2;
        color([c, c, c])
        translate(points[i])
            square(.2, center = true);
    }
}


module demo2() {
    points = [
        for(y = [0:.2:10])
            [
                for(x = [0:.2:10])
                [x, y]
            ]
    ];

    seed = rand(0, 256);
    function_grapher(
        [
            for(ri = [0:len(points) - 1])
                let(ns = pnoise2(points[ri], seed))
                    [
                        for(ci = [0:len(ns) - 1])
                            [points[ri][ci][0], points[ri][ci][1], ns[ci]]
                    ]
        ], 
        0.25)
    ;
}

demo1();

translate([12, 0]) 
    demo2();