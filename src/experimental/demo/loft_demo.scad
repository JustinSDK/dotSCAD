use <shape_starburst.scad>;
use <circle_path.scad>;
use <rotate_p.scad>;
use <experimental/loft.scad>;
    
sects = [
    for(i = 10; i >= 4; i = i - 1)
    [
        for(p = shape_starburst(15, 12, i % 2 == 1 ? i : i - 1)) rotate_p([p[0], p[1], 5 * (i - 4)], i * 10)
    ]
];
loft(sects, slices = 3);

translate([30, 0, 0])
difference() {
    loft(
        [
            [for(p = circle_path(10, $fn = 3)) [p[0], p[1], 15]],
            [for(p = circle_path(15, $fn = 24)) [p[0], p[1], 0]]        
        ],
        slices = 4
    );

    loft(
        [
            [for(p = circle_path(8, $fn = 3)) [p[0], p[1], 15.1]],
            [for(p = circle_path(13, $fn = 24)) [p[0], p[1], -0.1]]        
        ],
        slices = 4
    );    
}