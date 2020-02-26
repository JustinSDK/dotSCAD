use <util/rand.scad>;
use <experimental/tri_bisectors.scad>;

function h_lines_in_square(width) = 
    let(
        w = width / 2,
        i = ceil(rand() * 10) % 2,
        tris = i == 0 ? 
                [
                    [[0, 0], [width, 0], [width, width]],
                    [[0, 0], [width, width], [0, width]]
                ] 
                :
                [
                    [[width, 0], [0, width], [0, 0]],
                    [[width, 0], [width, width], [0, width]]
                ]
    )
    concat(tri_bisectors(tris[0]), tri_bisectors(tris[1]));

function hollow_out_square(size, width) =
    let(
        columns = size[0],
        rows = size[1]
    )
    [
        for(y = [0:width:width * rows - width])
            for(x = [0:width:width * columns - width])
                for(line = h_lines_in_square(width)) 
                    [for(p = line) p + [x, y]] 
    ];