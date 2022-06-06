use <util/rand.scad>
use <experimental/tri_bisectors.scad>

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
        rows = size[1],
        lines = h_lines_in_square(width)
    )
    [
        for(y = [0:width:width * rows - width], x = [0:width:width * columns - width])
        let(coord = [x, y])
        for(line = lines) [for(p = line) p + coord] 
    ];