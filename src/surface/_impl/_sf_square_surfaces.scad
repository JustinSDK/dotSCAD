function _sf_square_surfaces(levels, thickness, depth, invert) =
    let(
        rows = len(levels),
        columns = len(levels[0]),
        offset_z = invert ? 0 : thickness - depth,
        surface1 = [
            for(r = [0:rows - 1]) 
            [
                for(c = [0:columns - 1]) 
                let(lv = invert ? 255 - levels[rows - r - 1][c] : levels[rows - r - 1][c])
                [c, r, lv / 255 * depth + offset_z]
            ]
        ],
        surface2 = [
            for(r = [0:rows - 1]) 
            [
                for(c = [0:columns - 1]) 
                [c, r, 0]
            ]
        ]        
    )
    [surface1, surface2];
