use <_mz_comm.scad>;

// create a starting maze for being visited later.
function _rc_maze(rows, columns) =  [
    for(y = [0:rows - 1]) 
        for(x = [0:columns - 1]) 
            block(
                x, y, 
                // all blocks have top and right walls
                3, 
                // unvisited
                false 
            )
];

function _mz_mask(mask) = 
    let(
        rows = len(mask),
        columns = len(mask[0])
    )
    [
        for(y = [0:rows - 1])
            for(x = [0:columns - 1])
                mask[rows - y - 1][x] == 0 ?
                    block(
                        x, y, 						
                        4, // mask
                        true // visited
                    )
                    :
                    block(
                        x, y, 
                        // all blocks have top and right walls
                        3, // unvisited
                        false 
                    )
    ];