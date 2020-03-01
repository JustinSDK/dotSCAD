use <shape_starburst.scad>;
use <rotate_p.scad>;
use <util/reverse.scad>;
use <experimental/loft.scad>;
    
sects = [
    for(i = [4:10])
    reverse([
        for(p = shape_starburst(15, 12, i % 2 == 1 ? i : i - 1)) rotate_p([p[0], p[1], 5 * (i - 4)], i * 10)
    ])
];

loft(sects, slices = 3);