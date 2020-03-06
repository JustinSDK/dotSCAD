use <util/rand.scad>;
use <function_grapher.scad>;
use <experimental/pnoise2.scad>;
use <experimental/pnoise3.scad>;

module demo1() {
    points = [
        for(z = [0:.2:3])
            for(y = [0:.2:5])
                for(x = [0:.2:5])
                    [x, y, z]
    ];
    noise = pnoise3(points);

    for(i = [0:len(points) - 1]) {
        if(noise[i] > 0) {
            translate(points[i])
                cube(.2);
        }
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
    
    points_with_h = [
            for(ri = [0:len(points) - 1])
                let(ns = pnoise2(points[ri], seed))
                    [
                        for(ci = [0:len(ns) - 1])
                            [points[ri][ci][0], points[ri][ci][1], ns[ci] + 1]
                    ]
        ];
    
    h_scale = 1.5;
    for(row = points_with_h) {        
        for(i = [0:len(row) - 1]) {
            p = row[i];
            pts = [
                for(z = [0:.2:p[2] * h_scale]) [p[0], p[1], z]
            ];
            noise = pnoise3(pts, seed);
            for(j = [0:len(pts) - 1]) {
                if(noise[j] > 0) {
                    translate(pts[j])
                        cube(.2);
                }           
            }
        }
    }
    
    linear_extrude(.2)
        square(10);
}

demo1();

translate([8, 0]) 
    demo2();