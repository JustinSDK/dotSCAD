use <_impl/_mz_hex_walls.scad>;

function mz_hex_walls(blocks, rows, columns, cell_radius, wall_thickness, left_border = true, bottom_border = true) = 
    let(
        walls = [
             for(block = blocks)
                 for(wall = _build_cell(cell_radius, block))
                     wall
        ],
        left_pair_walls = left_border ? [
            for(y = [0:rows - 1]) 
            let(
                cell_p = _cell_position(cell_radius, 0, y),
                walls1 = _upper_left(cell_radius),
                walls2 = _down_left(cell_radius)
            )
            [
                 [walls1[0] + cell_p, walls1[1] + cell_p], 
                 [walls2[0] + cell_p, walls2[1] + cell_p]
            ]   
        ] : [],
        left_border_walls = [
            for(pair = left_pair_walls)
                for(wall = pair)
                    wall
        ],
        bottom_pair_walls = bottom_border ? [
            for(x = [0:columns - 1]) 
            let(
                cell_p = _cell_position(cell_radius, x, 0),
                walls1 = _down(cell_radius),
                walls2 = [
                    for(pair = (x % 2 == 0 ? [_down_left(cell_radius), _down_right(cell_radius)] : []))
                        for(wall = pair)
                            wall
                ]
            )
            walls2 == [] ? 
                [
                    [walls1[0] + cell_p, walls1[1] + cell_p]
                ] :
                [
                    [walls1[0] + cell_p, walls1[1] + cell_p], 
                    [walls2[0] + cell_p, walls2[1] + cell_p]
                ]   
        ] : [],
        bottom_border_walls = [
            for(pair = bottom_pair_walls)
                for(wall = pair)
                    wall
        ]
    )
    concat(walls, left_border_walls, bottom_border_walls);