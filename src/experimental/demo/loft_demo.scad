use <shape_starburst.scad>;
use <rotate_p.scad>;
use <experimental/loft.scad>;
    
sects = [
    for(i = [4:20])
    [
        for(p = shape_starburst(15, 12, i % 2 == 1 ? i : i - 1))    rotate_p([p[0], p[1], 3 * (i - 4)], i * 10)
    ]
];

loft(sects);