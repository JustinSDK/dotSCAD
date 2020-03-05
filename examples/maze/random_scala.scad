use <experimental/mz_blocks.scad>;
use <experimental/mz_get.scad>;
use <experimental/dedup.scad>;
use <experimental/has.scad>;

module random_scala(rows, columns, width, height) {
    blocks = mz_blocks(
        [1, 1],  
        rows, columns
    );
    
    function upper(x, y) =
        let(
            nx = (x - 1) * 2,
            ny = (y - 1) * 2
        )
        [[nx, ny + 2], [nx + 1, ny + 2], [nx + 2, ny + 2]];

    function right(x, y) =
        let(
            nx = (x - 1) * 2,
            ny = (y - 1) * 2
        )
        [[nx + 2, ny + 2], [nx + 2, ny + 1], [nx + 2, ny]];
        
    function upper_right(x, y) =
        let(
            nx = (x - 1) * 2,
            ny = (y - 1) * 2
        )
        [[nx, ny + 2], [nx + 1, ny + 2], [nx + 2, ny + 2], [nx + 2, ny + 1], [nx + 2, ny]];

    dot_pts = dedup(
        concat(
            [
                for(block = blocks)
                let(
                    x = mz_get(block, "x"),
                    y = mz_get(block, "y"),
                    wall_type = mz_get(block, "w"),
                    pts = wall_type == "UPPER_WALL" ? upper(x, y) :
                wall_type == "RIGHT_WALL" ? right(x, y) :
                wall_type == "UPPER_RIGHT_WALL" ? upper_right(x, y) : []
                )
                each pts
            ],
            [for(x = [0:columns * 2 - 1]) [x, 0]],
            [for(y = [0:rows * 2 - 1]) [0, y]]
        )
    );   

    function corner_value(dots, x, y) =
        let(
            c1 = has(dots, [x, y]) ? 1 : 0,
            c2 = has(dots, [x, y + 1]) ? 2 : 0,
            c3 = has(dots, [x + 1, y + 1]) ? 4 : 0,
            c4 = has(dots, [x + 1, y]) ? 8 : 0
        )
        c1 + c2 + c3 + c4;
 
    function dir(cr_value) = 
        lookup(cr_value, [
            [4,  0], [12, 0], [13, 0], // UP
            [1,  1], [3,  1], [7,  1], // DOWN
            [2,  2], [6,  2], [14, 2], // LEFT
            [8,  3], [9,  3], [11, 3]  // RIGHT
        ]);

    function travel(dot_pts, p, leng, i = 0) = 
        i == leng ? [] :
        let(
            dir_i = dir(corner_value(dot_pts, p[0], p[1])),
            nxt_p = p + [
                [0,  1],  // UP
                [0, -1],  // DOWN
                [-1, 0],  // LEFT
                [1,  0]   // RIGHT
            ][dir_i]
        )
        concat(
            [p], travel(dot_pts, nxt_p, leng, i + 1)
        );

    line = travel(dot_pts, [0, 0], rows * columns * 4);
    
    for(i = [0:len(line) - 1]) {
        p = line[i];
        translate(p)
        linear_extrude(height * i * 2 + height)
            square(width + 0.01, center = true);

        dir_i = dir(corner_value(dot_pts, p[0], p[1]));
            
        translate(
            p + [
                [0,  .5],  // UP
                [0, -.5],  // DOWN
                [-.5, 0],  // LEFT
                [.5,  0]   // RIGHT
            ][dir_i]
        )        
        linear_extrude(height * (2 * i + 1) + height)
            square(width + 0.01, center = true);
    }
}

random_scala(
    rows = 2, 
    columns = 3,
    width = .5,
    height = .25
);