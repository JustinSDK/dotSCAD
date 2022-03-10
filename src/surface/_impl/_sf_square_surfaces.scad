function _sf_square_surfaces(levels, thickness, depth, invert) =
    let(
        rows = len(levels),
        columns = len(levels[0]),
        lv_offset = invert ? function(lv) (255 - lv) / 255 * depth : 
                             function(lv) lv / 255 * depth + (thickness - depth),
        surface1 = [
            for(r = [0:rows - 1]) 
            let(level = levels[rows - r - 1])
            [
                for(c = [0:columns - 1]) 
                [c, r, lv_offset(level[c])]
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
